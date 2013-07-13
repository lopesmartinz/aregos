class AddColumnsToOrderActions < ActiveRecord::Migration
  def change
  	add_column :order_actions, :action_name, :string
  	add_column :order_actions, :status, :string
  end
end
