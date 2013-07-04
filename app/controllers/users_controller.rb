class UsersController < ApplicationController
  
  # definição do layout
  layout "inner_page"
  
  ##################################
  #### VERIFICAÇÕES PRÉVIAS
  ##################################

  # filtra se utilizador está autenticado
  # => não pode ver dados dos outros users mas pode criar utilizador/registo
  before_filter :check_signed_in_user, only: [:show]
  # filtra se utilizador deve ter acesso a funcionalidades
  before_filter :check_allowed_user, only: [:show]



  ##################################
  #### ACCÕES DEFAULT
  ##################################


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
      # alerta para user criado com sucesso
      flash[:notice] = "Bem vindo #{@user.name}. Obrigado por se ter registado."

      # autentica o user criado
      sign_in @user

      # envio do email de confirmação do registo para o utilizador
      Emails.user_registration_confirmation(@user).deliver

      # definir página após login com sucesso
      if exists_pending_cart?
        # redirecciona para a paǵina de checkout se existir um checkout pendente
        redirect_to ({:controller => :orders, :action => :new})
      else
          redirect_to @user
      end

  	else       
  		render 'new'
  	end
  end



  ##################################
  #### MÉTODOS PRIVADOS
  ##################################

  # trata utilizadores não autenticados
  private  
  def check_signed_in_user
    redirect_to signin_path unless user_is_signed_in?
  end


  # trata permissões do utilizador a esta página/funcionalidade
  private  
  def check_allowed_user
    user = User.find(params[:id])
    redirect_to signin_path unless is_allowed_user user
  end

end
