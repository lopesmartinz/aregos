# encoding: utf-8
class Admin::SessionsController < ApplicationController

	# definição do layout
	layout "admin/login"
	

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

		if !@user.nil? && @user.failed_password_attempt_count == 5
			flash[:alert] = "Acesso bloqueado devido ao excesso de tentativas de login erradas.<br/><br/>Utilize a opção de recuperação da password."
			render 'new'
		elsif !@user.nil? && @user.authenticate(params[:session][:password])
			# autenticar se o user existe e se a password corresponde

			# guardar cookie com o remeber_token correspondente ao utilizador
			# a função sign_in está definida no "sessions_helper"
			# só está acessível no controller porque no "application_controller"
			# => é feito o include do "sessions_helper"
			# => por omissão só estaria acessível nos views
			sign_in @user

			# alerta para user autenticado com sucesso
      		flash[:notice] = "Bem vindo #{@user.name}"

      		redirect_to admin_products_path			
		else
			# adicionar tentiva de login falhada
			if !@user.nil?
				@user.failed_password_attempt_count += 1

				# o attribute_accessor "is_failed_password_attempt_count_update"
				# => serve para evitar as validações quando só queremos actualizar o número de tentativas de login falhadas
				@user.is_failed_password_attempt_count_update = true

				@user.save
			end
			
			flash[:alert] = "Utilizador ou password errados."

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
    	redirect_to admin_path
	end

end
