class Product < ActiveRecord::Base
  
  attr_accessible :description, :name, :abstract, :description, :price, :stock_count, :picture, :is_active

  # relações com outras tabelas
  has_many :order_items
  has_many :orders, :through => :order_items
  has_many :carts, :through => :cart_items

end
