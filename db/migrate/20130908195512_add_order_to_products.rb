class AddOrderToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :order, :integer, :default => 0
  end
end
