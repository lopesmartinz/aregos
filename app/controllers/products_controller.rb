class ProductsController < ApplicationController
 	
 	# definição do layout
	layout "inner_page"
	
	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# Obter produtos válidos
	def index
		@products = Product.where("stock_count > 0 AND is_active = true");
	end


	# GET
	# Obter dados de produto seleccionado
	def show
		@product = Product.find(params[:id])
	end
end
