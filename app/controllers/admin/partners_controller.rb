class Admin::PartnersController < ApplicationController

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
	# listagem de parceiros
	def index
		@partners = Partner.all
	end


	# GET
	# detalhe de produto
	def show
		@partner = Partner.find(params[:id])
	end


	# GET
	# novo parceiro
	def new
		@partner = Partner.new
	end


	# POST
	# criação de parceiro
	def create
		@partner = Partner.new(params[:partner])

		if @partner.save
			render :show, :id => @partner.id
		else
			render new
		end
	end


	# GET
	# edição de parceiro
	def edit
		@partner = Partner.find(params[:id])
	end


	# PUT
	# edição de parceiro
	def update
		@partner = Partner.find(params[:id])

		if @partner.update_attributes(params[:partner])
			render :show, :id => @partner.id
		else
			render edit
		end
	end


	# DELETE
	# apagar parceiro
	def destroy
		@partner = Partner.find(params[:id])

		if @partner.delete
			redirect_to ({:controller => "admin/partners", :action => :index})
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