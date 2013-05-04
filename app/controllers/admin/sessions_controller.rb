class Admin::SessionsController < ApplicationController

	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# serve apenas para gerar o form de login
	def new		
	end


	# POST
	# faz autenticação do user
	def create
		# verificar se o user existe
		@user = User.find_by_email(params[:session][:email].downcase)
		
		# autenticar se o user existe e se a password corresponde
		if @user && @user.authenticate(params[:session][:password]) && @user.is_admin
			# guardar cookie com o remeber_token correspondente ao utilizador
			# a função sign_in está definida no "sessions_helper"
			# só está acessível no controller porque no "application_controller"
			# => é feito o include do "sessions_helper"
			# => por omissão só estaria acessível nos views
			sign_in @user

			redirect_to admin_products_path
		else
			render 'new'
		end
	end


	# DELETE
	# processa o logout
	def destroy
		# remove sessão do utilizador
		# => função definida no sessions_helper
		sign_out

		# redirecciona para a raiz do site
    	redirect_to "/"
	end

end
