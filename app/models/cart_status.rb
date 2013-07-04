class CartStatus < ActiveRecord::Base
  
  attr_accessible :name

  # relações com outras tabelas
  has_many :carts

end
