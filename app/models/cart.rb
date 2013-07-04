class Cart < ActiveRecord::Base

  attr_accessible :cart_status_id

  # relações com outras tabelas
  belongs_to :cart_status
  has_many :cart_items, :dependent => :destroy
  has_many :products, :through => :cart_items, :dependent => :destroy


  # Métodos da classe
  def add_item(product_id)
    # verificar se produto já existe no carrinho
    item = cart_items.where("product_id = ?", product_id).first

    # se já existir, aumenta-se a quantidade
    if !item.nil?
    	item.quantity += 1
    	item.save
    # se não existir, adiciona-se ao carrinho
    else
    	# obter dados do produto a adicionar
    	@product = Product.where("id = ?", product_id).first
    	cart_items.create(product_id: product_id, quantity: 1, price: @product.price)
    end
    
  end  

end
