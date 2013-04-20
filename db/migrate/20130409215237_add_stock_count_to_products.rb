class AddStockCountToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :stock_count, :integer
  end
end
