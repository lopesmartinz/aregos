class ChangeActiveOnProducts < ActiveRecord::Migration
  def up
  	rename_column :products, :active, :is_active
  end

  def down
  end
end
