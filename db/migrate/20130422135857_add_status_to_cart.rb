class AddStatusToCart < ActiveRecord::Migration
  def change
  	add_column :carts, :status, :integer, :default => 1
  end
end
