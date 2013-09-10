# encoding: utf-8

class PressReleasesController < ApplicationController

	# definição do layout
	layout "inner_page"

	
	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# Obter press releases
	def index
		@press_releases = PressRelease.all
	end

end
