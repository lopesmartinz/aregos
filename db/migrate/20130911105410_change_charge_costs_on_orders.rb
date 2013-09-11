class ChangeChargeCostsOnOrders < ActiveRecord::Migration
  def up
  	rename_column :orders, :charge_costs, :charging_costs
  end

  def down
  end
end
