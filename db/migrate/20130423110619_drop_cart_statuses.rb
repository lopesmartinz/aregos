class DropCartStatuses < ActiveRecord::Migration
  def up
  	drop_table :cart_statuses
  end

  def down
  end
end
