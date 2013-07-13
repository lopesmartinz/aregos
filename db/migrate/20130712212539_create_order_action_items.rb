class CreateOrderActionItems < ActiveRecord::Migration
  def change
    create_table :order_action_items do |t|

      t.timestamps
    end
  end
end
