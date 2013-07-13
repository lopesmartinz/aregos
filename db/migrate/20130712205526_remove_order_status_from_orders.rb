class RemoveOrderStatusFromOrders < ActiveRecord::Migration
  def up
  	remove_column :orders, :order_status_id
  end

  def down
  end
end
