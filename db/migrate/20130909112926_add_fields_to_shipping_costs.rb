class AddFieldsToShippingCosts < ActiveRecord::Migration
  def change
  	add_column :shipping_costs, :weight, :integer, :default => 0
  	add_column :shipping_costs, :price, :decimal, :precision => 8, :scale => 2, :default => 0
  end
end
