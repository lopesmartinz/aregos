class AddStatusToCarts2 < ActiveRecord::Migration
  def change
  	add_column :carts, :cart_status_id, :integer
  end
end
