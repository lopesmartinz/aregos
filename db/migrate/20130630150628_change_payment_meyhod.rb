class ChangePaymentMeyhod < ActiveRecord::Migration
  def up
  	change_column :orders, :payment_method, :integer
  end

  def down
  end
end
