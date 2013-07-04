class RemoveStatusFromCarts < ActiveRecord::Migration
  def up
  	remove_column :carts, :status
  end

  def down
  end
end
