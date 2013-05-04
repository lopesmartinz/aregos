class Order < ActiveRecord::Base
  
	attr_accessible :user_id, :reference, :address_line_1, :address_line_2, :zip_code, :city

	# relações com outras tabelas
	belongs_to :user
	has_many :order_items
	has_many :products, :through => :order_items

	#operações antes do insert
  	before_save :add_reference

	# validações
	validates :reference, presence: true, :uniqueness
	validates :address_line_1, presence: true
	validates :zip_code, presence: true
	validates :city, presence: true

	
	# Métodos da classe
	# adiciona item à encomenda actual
	def add_item(cart_item_id)
		cart_item = CartItem.find(cart_item_id)

		order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.price)
	end


	# criação da referência da encomenda
	private
	def add_reference
		self.reference = "ARGS" + (Order.last.id + 1).to_s
	end

end
