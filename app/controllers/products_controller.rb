# encoding: utf-8

class ProductsController < ApplicationController
 	
 	# definição do layout
	layout "inner_page"

	
	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# Obter produtos válidos
	def index
		@products = Product.where("is_active = true").order("priority_number ASC")
	end


	# GET
	# Obter dados de produto seleccionado
	def show
		@product = Product.find(params[:id])
	end




	##################################
	#### ACCÕES EXTRA
	##################################
	def highlights
		@products = Product.where("is_active = true").order("priority_number ASC")
	end

end
