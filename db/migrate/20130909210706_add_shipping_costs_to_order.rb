class AddShippingCostsToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :shipping_costs, :decimal, :precision => 8, :scale => 2, :default => 0
  	add_column :orders, :charge_costs, :decimal, :precision => 8, :scale => 2, :default => 0
  end
end
