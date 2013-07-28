class Admin::OrdersController < ApplicationController

	# definição do layout
	layout "admin/inner_page"
	

	##################################
	#### VERIFICAÇÕES PRÉVIAS
	##################################

	# filtra se o utilizador actual tem carrinho atribuído
	before_filter :check_if_is_admin_user





	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# listagem de encomendas
	def index
		@orders = Order.order("created_at DESC")
	end

	# GET
	# detalhe de encomenda
	def show
		@order = Order.find(params[:id])
	end





	##################################
	#### ACÇÕES EXTRA
	##################################
	
	# POST
	# adiciona acção sobre a encomenda
	def add_order_action
		order = Order.find(params[:id])
		order_action = OrderAction.find(params[:order_action_id])

		order.order_action_items.create(:order_action => order_action)

		redirect_to admin_order_path	
	end





	##################################
	#### MÉTODOS PRIVADOS
	##################################

	# verifica se existe um utilizador do tipo admin autenticado
	private
	def check_if_is_admin_user
		redirect_to admin_path unless !current_user.nil? && current_user.is_admin == true
	end
end
