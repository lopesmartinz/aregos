class AddFieldsToPartners < ActiveRecord::Migration
  def change
  	add_column :partners, :name, :string, :null => false
  	add_column :partners, :address, :string
  	add_column :partners, :phone, :string
  end
end
