class Admin::PressReleasesController < ApplicationController

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
	# listagem de press_releases
	def index
		@press_releases = PressRelease.all
	end


	# GET
	# detalhe de press_release
	def show
		@press_release = PressRelease.find(params[:id])
	end


	# GET
	# novo press_release
	def new
		@press_release = PressRelease.new
	end


	# POST
	# criação de press_release
	def create
		@press_release = PressRelease.new(params[:press_release])

		if @press_release.save
			render :show, :id => @press_release.id
		else
			render new
		end
	end


	# GET
	# edição de press_release
	def edit
		@press_release = PressRelease.find(params[:id])
	end


	# PUT
	# edição de press_release
	def update
		@press_release = PressRelease.find(params[:id])

		if @press_release.update_attributes(params[:press_release])
			render :show, :id => @press_release.id
		else
			render edit
		end
	end


	# DELETE
	# apagar press_release
	def destroy
		@press_release = PressRelease.find(params[:id])

		if @press_release.delete
			redirect_to ({:controller => "admin/press_releases", :action => :index})
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