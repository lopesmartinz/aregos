class AddAddressToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :address_line_1, :string, :null => false
  	add_column :orders, :address_line_2, :string
  	add_column :orders, :zip_code, :string, :null => false
  	add_column :orders, :city, :string, :null => false
  end
end
