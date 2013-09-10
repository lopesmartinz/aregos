class AddPaymentRelatedPaymentMethodsToOrderActions < ActiveRecord::Migration
  def change
  	add_column :order_actions, :related_payment_methods, :string
  end
end
