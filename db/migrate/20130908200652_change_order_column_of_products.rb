class ChangeOrderColumnOfProducts < ActiveRecord::Migration
  def up
  	rename_column :products, :order, :order_number
  end

  def down
  end
end
