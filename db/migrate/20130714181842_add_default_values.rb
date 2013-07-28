class AddDefaultValues < ActiveRecord::Migration
  def up
  	change_column :users, :failed_password_attempt_count, :integer, :default => 0
  end

  def down
  end
end
