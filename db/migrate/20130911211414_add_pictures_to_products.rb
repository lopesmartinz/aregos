class AddPicturesToProducts < ActiveRecord::Migration
  def change
  	rename_column :products, :picture, :picture_1
  	add_column :products, :picture_2, :string
  	add_column :products, :picture_3, :string
  	add_column :products, :picture_4, :string
  end
end
