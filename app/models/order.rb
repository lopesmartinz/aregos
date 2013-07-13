class Order < ActiveRecord::Base
  
	attr_accessible :user_id, :address_line_1, :address_line_2, :zip_code,
		:city, :country, :payment_method_id

	attr_accessor :first_name, :last_name,
		:card_type, :card_number,
		:card_verification, :card_expiration_year,
		:card_expiration_month, :card_expiration_date

	

	##################################
	#### RELAÇÕES COM OUTRAS TABELAS
	##################################

	belongs_to :user
	belongs_to :payment_method
	has_many :order_items, :dependent => :destroy
	has_many :order_action_items, :dependent => :destroy
	has_many :products, :through => :order_items
	has_many :order_actions, :through => :order_action_items




	##################################
	#### OPERAÇÕES ANTES DO INSERT
	##################################

  	before_save :add_reference
  	before_save :validate_credit_card
  	after_save :charge_credit_card



	##################################
	#### VALIDAÇÕES
	##################################

	validates :reference, uniqueness: true
	validates :address_line_1, presence: true
	validates :zip_code, presence: true
	validates :city, presence: true
	validates :country, presence: true
	validates :payment_method_id, presence: true

	validates_presence_of :first_name,
		:if => Proc.new { |o| o.payment_method_id == 1 }

	validates_presence_of :last_name,
		:if => Proc.new { |o| o.payment_method_id == 1 }

	validates_presence_of :card_type,
		:if => Proc.new { |o| o.payment_method_id == 1 }

	validates_presence_of :card_number,
		:if => Proc.new { |o| o.payment_method_id == 1 }

	validates_presence_of :card_number,
		:if => Proc.new { |o| o.payment_method_id == 1 }



	##################################
	#### MÉTODOS DA CLASSE
	##################################

	# adiciona item (do carrinho) à encomenda actual
	def add_item(cart_item_id)
		cart_item = CartItem.find(cart_item_id)

		order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.price)
	end

	# valida os dados do cartão de crédito e se tem fundos
	def validate_credit_card
		if self.payment_method_id == 1
			credit_card_data_is_valid?
			credit_card_has_enough_founds?
		end
	end

	# valida os dados do cartão de crédito indicados pelo utilizador
	def credit_card_data_is_valid?
		# cria objecto do cartão de crédito
		# => e valida os dados do cartão
		unless credit_card.valid?
			credit_card.errors.full_messages.each do |message|			
				# adiciona as mensagens de erro às outras mensagens de erro do model
				errors[:base] << message
			end
		end

		credit_card.valid?
	end

	# cria cartão de crédito com dados fornecidos
	# =>  pelo utilizador no formulário da encomenda	
	def credit_card
		@credit_card ||= ActiveMerchant::Billing::CreditCard.new(
			:type               => card_type,
			:number             => card_number,
			:verification_value => card_verification,
			:year               => card_expiration_year,
			:month              => card_expiration_month,
			:first_name         => first_name,
			:last_name          => last_name
		)
	end

	# verifica se o cartão de crédito tem o valor necessário
	def credit_card_has_enough_founds?
		# usa a gateway (constante) defida em "config/environments"	
		response = GATEWAY.authorize(1000, credit_card)
		
		# adiciona as mensagens de erro às outras mensagens de erro do model
		unless response.success?
			errors[:base] << response.message			
		end

		response.success?
	end

	# tenta cobrar o valor da encomenda no cartão de crédito	
	def charge_credit_card
		if self.payment_method_id == 1
			# usa a gateway (constante) defida em "config/environments"	
			response = GATEWAY.purchase(1000, credit_card)
			
			# adiciona as mensagens de erro às outras mensagens de erro do model
			unless response.success?
				errors[:base] << response.message
			end

			response.success?
		end
	end



	##################################
	#### MÉTODOS PRIVADOS
	##################################
	private
	def add_reference
		self.reference = "ARGS#{Order.count + 1}"
	end
end
