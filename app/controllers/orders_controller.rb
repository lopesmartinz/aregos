# encoding: utf-8

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
		#@orders = Order.where("user_id = ?", current_user.nil? ? -1 : current_user.id)
		@orders = current_user.orders.order("created_at DESC") unless current_user.nil?
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

		if !params[:order][:payment_method_id].blank? 
			@order.payment_method = PaymentMethod.find(params[:order][:payment_method_id])			
		end

		@order.shipping_costs = current_cart.total_shipping_costs

		if params[:order][:payment_method_id] == "2"
			@order.charging_costs = current_cart.total_charging_costs
		end

		# COMENTAR SE ACEITAR PAGAMENTOS COM CARTAO DE CREDITO
		@order.country = "Portugal"

=begin

DESCOMENTAR SE ACEITAR PAGAMENTOS COM CARTAO DE CREDITO

		@order.country = params[:order][:country]				

		# dados do cartão de crédito
		if @order.payment_method == PaymentMethod.find(3)
			@order.first_name = params[:order][:first_name]
			@order.last_name = params[:order][:last_name]
			@order.card_type = params[:order][:card_type]
			@order.card_number = params[:order][:card_number]
			@order.card_verification = params[:order][:card_verification]
			@order.card_expiration_year = params[:order]["card_expiration_date(1i)"]
			@order.card_expiration_month = params[:order]["card_expiration_date(2i)"]
		end

DESCOMENTAR SE ACEITAR PAGAMENTOS COM CARTAO DE CREDITO

=end

		# antes da criação (before_save no model), valida-se o cartão (caso seja esse o método de pagamento)
		if @order.save
			# registar acção de criação da encomenda
			@order.order_action_items.create(:order_action => OrderAction.find(1))

			# registar acção de colocação do valor da encomenda em débito
			# => apenas se o método de pagamento for "tranferência bancária"
			if @order.payment_method_id == 1
				@order.order_action_items.create(:order_action => OrderAction.find(2))
			end

			# transferir items do carrinho para a encomenda
			create_order_items(@order)					

			# fechar carrinho actual
			@cart = Cart.find(current_cart)
			@cart.cart_status = CartStatus.find(3)
			@cart.save

			flash[:notice] = "A encomenda foi submetida com sucesso."

			session.delete(:aregos_cart_id)

			# envio do email de confirmação da submissão da encomenda
      		Emails.order_creation(current_user, @order).deliver

			# redirecciona para detalhe da encomenda
			redirect_to @order
		else
			render 'new'
		end
			
	end


	

	##################################
	#### MÉTODOS PRIVADOS
	##################################

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


	# transferir items do carrinho para a encomenda
	private
	def create_order_items(order)		
		cart = Cart.find(current_cart)
		
		for item in cart.cart_items
			order.add_item(item.id)
		end

	end		

end
