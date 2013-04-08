class AddValidToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :valid, :boolean, :default => false
  end
end
