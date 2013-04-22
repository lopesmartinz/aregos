class ChangeStatusOnCarts < ActiveRecord::Migration
  def up
  	change_column :carts, :status, :string, :default => "created"
  end

  def down
  end
end
