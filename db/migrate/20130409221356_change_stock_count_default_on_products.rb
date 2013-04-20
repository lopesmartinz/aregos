class ChangeStockCountDefaultOnProducts < ActiveRecord::Migration
  def up
  	change_column :products, :stock_count, :integer, :default => 0
  end

  def down
  end
end
