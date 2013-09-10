class RemoveShippinCostsFromProducts < ActiveRecord::Migration
  def up
  	remove_column :products, :shipping_costs
  end

  def down
  end
end
