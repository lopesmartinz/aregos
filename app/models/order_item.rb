class OrderItem < ActiveRecord::Base
  
  attr_accessible :order_id, :product_id, :quantity, :price

  # relações com outras tabelas
  belongs_to :product
  belongs_to :order

end
