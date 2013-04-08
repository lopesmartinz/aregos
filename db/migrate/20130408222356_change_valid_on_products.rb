class ChangeValidOnProducts < ActiveRecord::Migration
  def up
  	rename_column :products, :valid, :active
  end

  def down
  end
end
