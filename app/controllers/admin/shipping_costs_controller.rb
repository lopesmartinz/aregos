class Admin::ShippingCostsController < ApplicationController

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
	# listagem de portes de envio
	def index
		@shipping_costs = ShippingCost.all
	end


	# GET
	# detalhe de portes de envio
	def show
		@shipping_cost = ShippingCost.find(params[:id])
	end


	# GET
	# novo porte de envio
	def new
		@shipping_cost = ShippingCost.new
	end


	# POST
	# criação de porte de envio
	def create
		@shipping_cost = ShippingCost.new(params[:shipping_cost])

		if @shipping_cost.save
			render :show, :id => @shipping_cost.id
		else
			render new
		end
	end


	# GET
	# edição de porte de envio
	def edit
		@shipping_cost = ShippingCost.find(params[:id])
	end


	# PUT
	# edição de portes de envio
	def update
		@shipping_cost = ShippingCost.find(params[:id])

		if @shipping_cost.update_attributes(params[:shipping_cost])
			render :show, :id => @shipping_cost.id
		else
			render edit
		end
	end


	# DELETE
	# apagar portes de envio
	def destroy
		@shipping_cost = ShippingCost.find(params[:id])

		if @shipping_cost.delete
			redirect_to ({:controller => "admin/shipping_costs", :action => :index})
		end
	end





	##################################
	#### MÉTODOS PRIVADOS
	##################################

	# verifica se existe um utilizador do tipo admin autenticado
	def check_if_is_admin_user
		redirect_to admin_path unless !current_user.nil? && current_user.is_admin == true
	end

end