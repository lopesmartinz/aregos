class AddNameToOrderStatus < ActiveRecord::Migration
  def change
  	add_column :order_statuses, :name, :string
  end
end
