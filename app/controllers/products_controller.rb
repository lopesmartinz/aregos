class ProductsController < ApplicationController
	
	# GET
	# Obter produtos válidos
	def index
		# o ? será substituído pelo valor correspondente na hash
		# evita a sql injection
		@products = Product.where("active = ?", true);
	end


	# GET
	# Obter dados de produto seleccionado
	def show
		@product = Product.find(params[:id])
	end
end
