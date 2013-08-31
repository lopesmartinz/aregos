class ProductsController < ApplicationController
 	
 	# definição do layout
	layout :resolve_layout

	
	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# Obter produtos válidos
	def index
		@products = Product.where("stock_count > 0 AND is_active = true")
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
		@products = Product.where("stock_count > 0 AND is_active = true")
	end




	##################################
	#### MÉTODOS PRIVADOS
	##################################
	private
	def resolve_layout
		case action_name
	    when "show"
	      "detail_page"		    
	    else
	      "inner_page"
	    end		
	end

end
