class OrdersController < ApplicationController

	# definição do layout
	layout "inner_page"
	
	##################################
	#### VERIFICAÇÕES PRÉVIAS
	##################################

	# verifica se o utilizador pode criar encomendas
	before_filter :user_has_permission_to_create, only: [:new, :create]

	# verifica se o utilizador tem permissão para ver o detalhe da encomenda
	before_filter :user_has_permission_to_view, only: [:show]

	# verifica se o utilizador tem permissão para pesquisar encomendas
	before_filter :user_has_permission_to_search, only: [:search, :search_results]




	##################################
	#### ACCÕES DEFAULT
	##################################
	
	# GET
	# detalhe da encomenda	
	def show
		@order = Order.find(params[:id])
	end


	# GET
	# formulário de dados da encomenda	
	def new
		@order = Order.new
	end


	# POST
	# criação da encomenda
	def create
		# criar encomenda com dados preenchidos no formulário
		@order = Order.new(params[:order])
		@order.user_id = current_user.id

		if @order.save
			# criar items da encomenda
			create_order_items(@order.id)

			# fechar carrinho actual
			current_cart.update_attributes(status: "closed")
			session.delete(:aregos_cart_id)

			# redirecciona para detalhe da encomenda
			redirect_to @order
		else
			render 'new'
		end

	end


	# GET
	# serve apenas para criar o formulário de pesquisa
	def search
	end


	# GET
	# resultado da pesquisa
	def search_results

		order = Order.new

		if !params[:order].nil? && !params[:order][:reference].nil?
			order = Order.find_by_reference(params[:order][:reference])
		end

		if !order.nil?
			redirect_to order
		else
			render 'search'
		end	

	end



	##################################
	#### MÉTODOS PRIVADOS
	##################################
	
	# criação de items da encomenda
	private
	def create_order_items(order_id)

		order = Order.find(order_id)
		cart = Cart.find(current_cart)
		
		for item in cart.cart_items
			order.add_item(item.id)
		end

	end

	
	# verificar se utilizador está autenticado e tem carrinho
	# => são estas as condições para existir ser criada uma encomenda
	private
	def user_has_permission_to_create
		redirect_to root_path unless !current_user.nil? && !current_cart.nil?
	end


	# verificar se utilizador é dono da encomenda
	private
	def user_has_permission_to_view
		order = Order.find(params[:id])

		redirect_to root_path unless !current_user.nil? && current_user == order.user
	end


	# verificar se utilizador pode pesuisar encomendas
	private
	def user_has_permission_to_search
		redirect_to root_path unless !current_user.nil?
	end

end
