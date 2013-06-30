class PaymentMethod < ActiveRecord::Base

	attr_accessible :name


  	##################################
	#### RELAÇÕES COM OUTRAS TABELAS
	##################################

	has_many :orders

end
