class ChangeOrderColumnOfProductsToPriority < ActiveRecord::Migration
  def up
  	rename_column :products, :order_number, :priority_number
  end

  def down
  end
end
