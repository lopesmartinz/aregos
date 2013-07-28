class AddFailedPasswordAttemptCountToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :failed_password_attempt_count, :integer
  end
end
