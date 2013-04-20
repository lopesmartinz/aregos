class CartsController < ApplicationController

	##################################
	#### VERIFICAÇÕES PRÉVIAS
	##################################

	# filtra se o utilizador actual tem carrinho atribuído
	before_filter :check_if_has_cart, only: [:show]




	##################################
	#### ACCÕES
	##################################

	def show
		@cart = current_cart
	end


	def destroy
		@cart = current_cart
		@cart.delete

		session[:aregos_cart_id] = nil

		redirect_to products_path
	end



	##################################
	#### MÉTODOS GENÉRICOS
	##################################

	# adiciona produto ao carrinho  
	def add_to_cart
		# cria carrinho se ainda não existir
		if current_cart.nil?
			@cart = create_cart
		else
			@cart = Cart.find(current_cart)
		end

		# adicionar item ao carrinho
		# => add_item é um método do model "cart"
		@cart.add_item(params[:product_id])

		redirect_to @cart
	end



	##################################
	#### MÉTODOS PRIVADOS
	##################################

	# cria carrinho, guarda o id em sessão e devolve o carrinho actual
	private
	def create_cart
		@cart = Cart.create

		session[:aregos_cart_id] = @cart.id

		@cart
	end


	# verifica permissões para ver carrinho
	private
	def check_if_has_cart
		redirect_to products_path unless !current_cart.nil?
	end

end
