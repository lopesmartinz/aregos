class AddPaymentMethodToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :payment_method, :string
  	add_column :orders, :country, :string
  end
end
