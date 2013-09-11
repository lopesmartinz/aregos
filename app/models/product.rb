class Product < ActiveRecord::Base
  
  attr_accessible :description, :name, :abstract, :description, :price,
   :stock_count, :picture_1, :picture_2, :picture_3, :picture_4,
    :thumbnail, :is_active, :priority_number, :weight

  # relações com outras tabelas
  has_many :order_items, :dependent => :destroy
  has_many :orders, :through => :order_items
  has_many :carts, :through => :cart_items, :dependent => :destroy

end
