class CreateOrderActions < ActiveRecord::Migration
  def change
    create_table :order_actions do |t|

      t.timestamps
    end
  end
end
