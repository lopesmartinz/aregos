# encoding: utf-8

class PartnersController < ApplicationController

	# definição do layout
	layout "inner_page"

  

	##################################
	#### ACCÕES DEFAULT
	##################################
	def index
		@partners = Partner.All
	end

end