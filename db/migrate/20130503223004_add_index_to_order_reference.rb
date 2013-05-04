class AddIndexToOrderReference < ActiveRecord::Migration
  def change
  	add_index :orders, :reference, :unique => true
  end
end
