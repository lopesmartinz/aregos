class OrderAction < ActiveRecord::Base

  attr_accessible :action_name, :status, :related_payment_methods

	

	##################################
	#### RELAÇÕES COM OUTRAS TABELAS
	##################################

	has_many :order_action_items, :dependent => :destroy
	has_many :orders, :through => :order_action_items

end
