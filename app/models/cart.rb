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

  # obter preço total
  def total_price
    total = 0
    
    if self.cart_items.count > 0
      total = self.cart_items.sum("price * quantity") + self.total_shipping_costs
    end

    total
  end

  # obter peso total dos itens do carrinho
  def total_weight
    total = 0
    
    self.cart_items.each do |item|
      total += item.quantity * item.product.weight
    end

    total
  end

  # obter total de portes de envio
  def total_shipping_costs
    total_costs = 0

    if self.cart_items.count > 0
      correspondent_costs = ShippingCost.where("weight >= ?", self.total_weight).order("weight ASC").first
      total_costs = correspondent_costs.price unless correspondent_costs.nil?
    end

    total_costs
  end

  # obter valor do envio à cobrança
  def total_charging_costs
    total_costs = 0

    if self.cart_items.count > 0
      correspondent_costs = ChargingCost.where("weight >= ?", self.total_weight).order("weight ASC").first
      total_costs = correspondent_costs.price unless correspondent_costs.nil?
    end

    total_costs
  end

end
