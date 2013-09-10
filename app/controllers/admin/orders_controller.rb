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

		# envio dos e-mails correspondentes a cada acção
		# e-mail de confirmação da recepção do pagamento
		if order_action.id == 3
			Emails.order_payment_received(order.user, order).deliver
		end

		# e-mail de início do processamento da encomenda
		if order_action.id == 4
			Emails.order_process_start(order.user, order).deliver
		end

		# e-mail de confirmação do envio da encomenda
		if order_action.id == 5
			Emails.order_sent(order.user, order).deliver
		end

		# e-mail de conclusão da encomenda
		if order_action.id == 6
			Emails.order_closed(order.user, order).deliver
		end

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
