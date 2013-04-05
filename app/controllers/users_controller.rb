class UsersController < ApplicationController
  
  ##################################
  #### VERIFICAÇÕES PRÉVIAS
  ##################################

  # filtra se utilizador está autenticado
  # => não pode ver dados dos outros users mas pode criar utilizador/registo
  before_filter :signed_in_user, only: [:show]
  # filtra se utilizador deve ter acesso a funcionalidades
  before_filter :allowed_user, only: [:show]



  ##################################
  #### ACCÕES
  ##################################

  # GET
  # obtem dados do utilizador
  def show
  	# o parâmetro ":id" vem da querystring
    @user = User.find(params[:id])
  end


  # GET
  # instancia novo user para carregar form
  def new
    # user instanciado com base na estrutura do model
    @user = User.new
  end


  # POST
  # cria registo do utilizador
  def create
  	# instancia user do model e atribui valores aos campos
    # => de acordo com os valores preenchidos no form
    @user = User.new(params[:user])

  	# guarda user na base de dados
    if @user.save
      # autentica o user criado
      sign_in @user
  		redirect_to @user
  	else
  		render 'new'
  	end
  end



  ##################################
  #### MÉTODOS GENÉRICOS
  ##################################

  # trata utilizadores não autenticados
  private  
  def signed_in_user
    redirect_to signin_path unless signed_in?
  end


  # trata permissões do utilizador a esta página/funcionalidade
  private  
  def allowed_user
    user = User.find(params[:id])
    redirect_to signin_path unless is_allowed_user user
  end

end
