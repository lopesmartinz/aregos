# encoding: utf-8

class CartsController < ApplicationController

	# definição do layout
	layout "inner_page"
	
	##################################
	#### VERIFICAÇÕES PRÉVIAS
	##################################

	# filtra se o utilizador actual tem carrinho atribuído
	before_filter :check_if_has_cart, only: [:index, :show]




	##################################
	#### ACCÕES DEFAULT
	##################################

	# redirecciona para o carrinho actual
	def index
		redirect_to current_cart
	end


	# GET
	# mostra o carrinho actual
	def show
		@cart = current_cart
		
		# para mostrar a listagem de produtos na barra lateral (partial)
		@products = Product.all
	end


	# DELETE
	# apaga o carrinho actual
	def destroy
		@cart = current_cart
		@cart.delete

		session.delete(:aregos_cart_id)

		flash[:notice] = "O carrinho de compras foi eliminado."

		redirect_to products_path
	end



	##################################
	#### ACÇÕES EXTRA
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

		flash[:notice] = "O produto foi adicionado ao carrinho de compras."

		redirect_to @cart
	end


	# processa o checkout do carrinho
	def checkout
		@cart = Cart.find(current_cart)

		# operações se o utilizador estiver autenticado
		if user_is_signed_in?
			# carrinho só é fechado depois da encomenda ser feita com sucesso			
			redirect_to ({:controller => :orders, :action => :new})
		else
			# dar o carrinho como pendente se o utilizador não estiver autenticado
			@cart.cart_status = CartStatus.find(2)
			@cart.save

			# render da página de checkout do carrinho com opções de login e registo
		end		
	end



	##################################
	#### MÉTODOS PRIVADOS
	##################################

	# cria carrinho, guarda o id em sessão e devolve o carrinho actual
	private
	def create_cart
		@cart = Cart.new
		@cart.cart_status = CartStatus.find(1)
		@cart.save

		session[:aregos_cart_id] = @cart.id

		@cart
	end


	# verifica permissões para ver carrinho
	private
	def check_if_has_cart
		redirect_to products_path unless !current_cart.nil?
	end

end
