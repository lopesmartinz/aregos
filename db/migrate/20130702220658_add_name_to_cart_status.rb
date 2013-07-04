class AddNameToCartStatus < ActiveRecord::Migration
  def change
  	add_column :cart_statuses, :name, :string
  end
end
