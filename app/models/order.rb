class Order < ActiveRecord::Base
  
  attr_accessible :reference, :user_id

  # relações com outras tabelas
  belongs_to :user
  has_many :order_items
  has_many :products, :through => :order_items

end
