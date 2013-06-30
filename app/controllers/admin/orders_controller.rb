class Admin::OrdersController < ApplicationController

	# definição do layout
	layout "backoffice"
	

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
		@orders = Order.all
	end

	# GET
	# detalhe de encomenda
	def show
		@order = Order.find(params[:id])
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
