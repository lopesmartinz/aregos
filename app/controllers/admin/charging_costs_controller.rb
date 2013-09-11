class Admin::ChargingCostsController < ApplicationController

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
	# listagem de custos de cobrança
	def index
		@charging_costs = ChargingCost.all
	end


	# GET
	# detalhe de custos de cobrança
	def show
		@charging_cost = ChargingCost.find(params[:id])
	end


	# GET
	# novo custos de cobrança
	def new
		@charging_cost = ChargingCost.new
	end


	# POST
	# criação de custos de cobrança
	def create
		@charging_cost = ChargingCost.new(params[:charging_cost])

		if @charging_cost.save
			render :show, :id => @charging_cost.id
		else
			render new
		end
	end


	# GET
	# edição de custos de cobrança
	def edit
		@charging_cost = ChargingCost.find(params[:id])
	end


	# PUT
	# edição de custos de cobrança
	def update
		@charging_cost = ChargingCost.find(params[:id])

		if @charging_cost.update_attributes(params[:charging_cost])
			render :show, :id => @charging_cost.id
		else
			render edit
		end
	end


	# DELETE
	# apagar custos de cobrança
	def destroy
		@charging_cost = ChargingCost.find(params[:id])

		if @charging_cost.delete
			redirect_to ({:controller => "admin/charging_costs", :action => :index})
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