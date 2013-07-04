class OrderStatus < ActiveRecord::Base

  attr_accessible :name

  # relações com outras tabelas
  has_many :orders

end
