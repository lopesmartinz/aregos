class GeneralInteractionsController < ApplicationController

	# definição do layout
	layout "inner_page"



	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# criação do formulário de submissão
	def new		
	end


	# POST
	# guardar dados da interacção
	def create
		# envio dos dados inseridos pelo utilizador para o e-mail
		@subject = params[:general_interactions][:subject]
		@description = params[:general_interactions][:description]
      	Emails.general_interaction_submission(@subject, @description).deliver

      	flash[:notice] = "A sua mensagem foi enviada com sucesso."

      	redirect_to root_path
	end

end
