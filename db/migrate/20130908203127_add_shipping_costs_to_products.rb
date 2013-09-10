class AddShippingCostsToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :shipping_costs, :decimal, :precision => 8, :scale => 2
  end
end
