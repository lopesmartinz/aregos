class Product < ActiveRecord::Base
  
  attr_accessible :description, :name, :abstract, :description, :price, :stock_count, :picture, :thumbnail, :is_active, :priority_number, :weight

  # relações com outras tabelas
  has_many :order_items, :dependent => :destroy
  has_many :orders, :through => :order_items
  has_many :carts, :through => :cart_items, :dependent => :destroy

end
