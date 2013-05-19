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



	##################################
	#### ACCÕES DEFAULT
	##################################
	
	# GET
	# listagem de encomendas do utilizador
	def index
		@orders = Order.where("user_id = ?", current_user.nil? ? -1 : current_user.id)
	end


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
		@order = current_user.orders.new
		@order.address_line_1 = params[:order][:address_line_1]
		@order.address_line_2 = params[:order][:address_line_2]
		@order.zip_code = params[:order][:zip_code]
		@order.city = params[:order][:city]

		if payment_was_successful? && @order.save
			# transferir items do carrinho para a encomenda
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


	

	##################################
	#### MÉTODOS PRIVADOS
	##################################

	private
	def payment_was_successful?
		success = false

		if @order.validate_card
			success = @order.charge_credit_card
		end

		success
	end

		
	# transferir items do carrinho para a encomenda
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

end