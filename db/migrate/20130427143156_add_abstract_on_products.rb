class AddAbstractOnProducts < ActiveRecord::Migration
  def up
  	add_column :products, :abstract, :text
  end

  def down
  end
end
