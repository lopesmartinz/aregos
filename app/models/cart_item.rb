class CartItem < ActiveRecord::Base
  
  attr_accessible :cart_id, :product_id, :quantity, :price

  # relações com outras tabelas
  belongs_to :product
  belongs_to :cart

end
