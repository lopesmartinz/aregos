class CreateShippingCosts < ActiveRecord::Migration
  def change
    create_table :shipping_costs do |t|

      t.timestamps
    end
  end
end
