class AddColumnsToOrderActionItems < ActiveRecord::Migration
  def change
  	add_column :order_action_items, :order_id, :integer
  	add_column :order_action_items, :order_action_id, :integer
  end
end
