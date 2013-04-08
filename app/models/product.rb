class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :active
end
