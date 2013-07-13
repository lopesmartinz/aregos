class RemoveTableOrderStatuses < ActiveRecord::Migration
  def up
  	drop_table :order_statuses
  end

  def down
  end
end
