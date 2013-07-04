class ChangeOrderPaymentMethodType < ActiveRecord::Migration
  def up
  	remove_column :orders, :payment_method
  	add_column :orders, :payment_method_id, :integer
  end

  def down
  end
end
