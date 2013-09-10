# encoding: utf-8

class GeneralInteractionsController < ApplicationController

	# definição do layout
	layout "inner_page"



	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# criação do formulário de submissão
	def new
		@general_interaction = GeneralInteraction.new	
	end


	# POST
	# guardar dados da interacção
	def create
		@general_interaction = GeneralInteraction.new(params[:general_interaction])

		if @general_interaction.save

			# envio dos dados inseridos pelo utilizador para o e-mail
		  	Emails.general_interaction_submission(@general_interaction).deliver

		  	flash[:notice] = "A sua mensagem foi enviada com sucesso."

		  	redirect_to root_path
		else
			render "new"
		end
	end

end
