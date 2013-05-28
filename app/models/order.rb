class Order < ActiveRecord::Base
  
	attr_accessible :user_id, :address_line_1, :address_line_2, :zip_code,
		:city, :country, :payment_method

	attr_accessor :first_name, :last_name,
		:card_type, :card_number,
		:card_verification, :card_expiration_year,
		:card_expiration_month, :card_expiration_date

	

	##################################
	#### RELAÇÕES COM OUTRAS TABELAS
	##################################

	belongs_to :user
	has_many :order_items, :dependent => :destroy
	has_many :products, :through => :order_items



	##################################
	#### OPERAÇÕES ANTES DO INSERT
	##################################

  	before_save :add_reference



	##################################
	#### VALIDAÇÕES
	##################################

	validates :reference, uniqueness: true
	validates :address_line_1, presence: true
	validates :zip_code, presence: true
	validates :city, presence: true
	validates :country, presence: true
	validates :payment_method, presence: true
	
	#validates :first_name, presence: true
	#validates :last_name, presence: true
	#validates :card_type, presence: true
	#validates :card_number, presence: true
	#validates :card_verification, presence: true
	#validates :card_expiration_year, presence: true
	#validates :card_expiration_month, presence: true

	

	##################################
	#### MÉTODOS DA CLASSE
	##################################

	# adiciona item (do carrinho) à encomenda actual
	def add_item(cart_item_id)
		cart_item = CartItem.find(cart_item_id)

		order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.price)
	end

	# valida cartão de crédito
	def validate_card
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

	# tenta cobrar o valor da encomenda no cartão de crédito	
	def charge_credit_card
		# usa a gateway (constante) defida em "config/environments"	
		response = GATEWAY.purchase(1000, credit_card)
		
		# adiciona as mensagens de erro às outras mensagens de erro do model
		unless response.success?
			response.errors.full_messages.each do |message|
				errors[:base] << message
			end
		end

		response.success?
	end



	##################################
	#### MÉTODOS PRIVADOS
	##################################
	private
	def add_reference
		self.reference = "ARGS#{Order.last.id + 1}"
	end
end
