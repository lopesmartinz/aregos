class AddThumbnailToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :thumbnail, :string
  end
end
