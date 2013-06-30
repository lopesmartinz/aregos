class Admin::ProductsController < ApplicationController

	# definição do layout
	layout "backoffice"
	

	##################################
	#### VERIFICAÇÕES PRÉVIAS
	##################################

	# filtra se o utilizador actual tem carrinho atribuído
	before_filter :check_if_is_admin_user




	##################################
	#### ACCÕES DEFAULT
	##################################

	# GET
	# listagem de produtos
	def index
		@products = Product.all
	end


	# GET
	# detalhe de produto
	def show
		@product = Product.find(params[:id])
	end


	# GET
	# formulário de criação de produto
	def new
		@product = Product.new
	end


	# GET
	# edição de produto
	def edit
		@product = Product.find(params[:id])
	end


	# POST
	# criação de produto com dados preenchidos no formulário
	def create
		@product = Product.new

		@product.name = params[:product][:name]
		@product.abstract = params[:product][:abstract]
		@product.description = params[:product][:description]
		@product.price = params[:product][:price]
		@product.stock_count = params[:product][:stock_count]		
		@product.is_active = params[:product][:is_active]

		if !params[:product][:picture].nil?
			@product.picture = params[:product][:picture].original_filename

			# upload da imagem
			upload_picture
		end

		if @product.save
			render :show, :id => @product.id
		else
			render :new
		end
	end


	# PUT
	# criação de produto com dados preenchidos no formulário
	def update
		@product = Product.find(params[:id])
		
		@product.name = params[:product][:name]
		@product.abstract = params[:product][:abstract]
		@product.description = params[:product][:description]
		@product.price = params[:product][:price]
		@product.stock_count = params[:product][:stock_count]		
		@product.is_active = params[:product][:is_active]

		if !params[:product][:picture].nil?
			@product.picture = params[:product][:picture].original_filename

			# upload da imagem
			upload_picture
		end
		

		if @product.save
			render :show, :id => @product.id
		else
			render :edit
		end
	end


	# DELETE
	# criação de produto com dados preenchidos no formulário
	def destroy
		@product = Product.find(params[:id])

		if @product.delete
			redirect_to :index
		end
	end




	##################################
	#### MÉTODOS PRIVADOS
	##################################

	# verifica se existe um utilizador do tipo admin autenticado
	def check_if_is_admin_user
		redirect_to admin_path unless !current_user.nil? && current_user.is_admin == true
	end


	# verifica se existe um utilizador do tipo admin autenticado
	def upload_picture
		picture = params[:product][:picture]

		directory = "public/images/upload"
    	path = File.join(directory, picture.original_filename)

		File.open(path, 'wb') do |file|
			file.write(picture.read)
		end
	end

end
