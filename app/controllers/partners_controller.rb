class PartnersController < ApplicationController

	# definição do layout
	layout "inner_page"

  

	##################################
	#### ACCÕES DEFAULT
	##################################
	def index
		@partners = Partner.all
	end

end