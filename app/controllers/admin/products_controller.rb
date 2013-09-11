class Admin::ProductsController < ApplicationController

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
		@product.weight = params[:product][:weight]
		@product.stock_count = params[:product][:stock_count]
		@product.priority_number = params[:product][:priority_number]	
		@product.is_active = params[:product][:is_active]

		product_id = 1
		product_id = Product.last.id + 1 unless Product.last.nil?

		# upload das imagens
		# o nome das imagens será "product_" + "id do produto" + "_picture_" + "numero da imagem"
		# picture_1
		if !params[:product][:picture_1].nil?
			file_extension = File.extname(params[:product][:picture_1].original_filename)
			file_new_name = "product_#{product_id}_picture_1#{file_extension}"
			@product.picture_1 = file_new_name
			
			upload_image(params[:product][:picture_1], "public/images/products/", file_new_name)
		end

		# picture_2
		if !params[:product][:picture_2].nil?
			file_extension = File.extname(params[:product][:picture_2].original_filename)
			file_new_name = "product_#{product_id}_picture_2#{file_extension}"
			@product.picture_2 = file_new_name
			
			upload_image(params[:product][:picture_2], "public/images/products/", file_new_name)
		end

		# picture_3
		if !params[:product][:picture_3].nil?
			file_extension = File.extname(params[:product][:picture_3].original_filename)
			file_new_name = "product_#{product_id}_picture_3#{file_extension}"
			@product.picture_3 = file_new_name
			
			upload_image(params[:product][:picture_3], "public/images/products/", file_new_name)
		end

		# picture_4
		if !params[:product][:picture_4].nil?
			file_extension = File.extname(params[:product][:picture_4].original_filename)
			file_new_name = "product_#{product_id}_picture_4#{file_extension}"
			@product.picture_4 = file_new_name
			
			upload_image(params[:product][:picture_4], "public/images/products/", file_new_name)
		end

		# upload do thumbnail
		# o nome do thumbnail será "product_" + "id do produto" + "_thumbnail"
		if !params[:product][:thumbnail].nil?
			file_extension = File.extname(params[:product][:thumbnail].original_filename)
			file_new_name = "product_#{@product.id}_thumbnail#{file_extension}"
			@product.thumbnail = file_new_name

			upload_image(params[:product][:thumbnail], "public/images/products/", file_new_name)
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
		@product.weight = params[:product][:weight]
		@product.stock_count = params[:product][:stock_count]
		@product.priority_number = params[:product][:priority_number]		
		@product.is_active = params[:product][:is_active]

		# upload das imagens
		# o nome das imagens será "product_" + "id do produto" + "_picture_" + "numero da imagem"
		# picture_1
		if !params[:product][:picture_1].nil?
			file_extension = File.extname(params[:product][:picture_1].original_filename)
			file_new_name = "product_#{@product.id}_picture_1#{file_extension}"
			@product.picture_1 = file_new_name
			
			upload_image(params[:product][:picture_1], "public/images/products/", file_new_name)
		end

		# picture_2
		if !params[:product][:picture_2].nil?
			file_extension = File.extname(params[:product][:picture_2].original_filename)
			file_new_name = "product_#{@product.id}_picture_2#{file_extension}"
			@product.picture_2 = file_new_name
			
			upload_image(params[:product][:picture_2], "public/images/products/", file_new_name)
		end

		# picture_3
		if !params[:product][:picture_3].nil?
			file_extension = File.extname(params[:product][:picture_3].original_filename)
			file_new_name = "product_#{@product.id}_picture_3#{file_extension}"
			@product.picture_3 = file_new_name
			
			upload_image(params[:product][:picture_3], "public/images/products/", file_new_name)
		end

		# picture_4
		if !params[:product][:picture_4].nil?
			file_extension = File.extname(params[:product][:picture_4].original_filename)
			file_new_name = "product_#{@product.id}_picture_4#{file_extension}"
			@product.picture_4 = file_new_name
			
			upload_image(params[:product][:picture_4], "public/images/products/", file_new_name)
		end

		# upload do thumbnail
		# o nome do thumbnail será "product_" + "id do produto" + "_thumbnail"
		if !params[:product][:thumbnail].nil?
			file_extension = File.extname(params[:product][:thumbnail].original_filename)
			file_new_name = "product_#{@product.id}_thumbnail#{file_extension}"
			@product.thumbnail = file_new_name

			upload_image(params[:product][:thumbnail], "public/images/products/", file_new_name)
		end

		if @product.save
			render :show, :id => @product.id
		else
			render :edit
		end
	end


	# DELETE
	# apagar produto
	def destroy
		@product = Product.find(params[:id])

		if @product.delete
			redirect_to ({:controller => "admin/products", :action => :index})
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
	def upload_image(image, directory_path, image_name)
    	full_path = File.join(directory_path, image_name)

		File.open(full_path, 'wb') do |file|
			file.write(image.read)
		end
	end

end
