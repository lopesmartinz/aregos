class AddWeightToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :weight, :integer, default: 0
  end
end
