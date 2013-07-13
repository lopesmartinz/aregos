class OrderActionItem < ActiveRecord::Base

	attr_accessible :order, :order_action



	##################################
	#### RELAÇÕES COM OUTRAS TABELAS
	##################################

	belongs_to :order
	belongs_to :order_action

end
