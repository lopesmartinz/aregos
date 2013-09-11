class CreateChargingCosts < ActiveRecord::Migration
  def change
    create_table :charging_costs do |t|

      t.timestamps
    end
  end
end
