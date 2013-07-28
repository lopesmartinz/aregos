# encoding: utf-8

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
  #### ACÇÕES EXTRA
  ##################################
  
  # GET
  # a action "recover_password" serve para gerar o form em que o utilizador indica o endereço de e-mail
  def recover_password
    @user = User.new
  end


  #POST
  # a action "send_password_recover_email" é a ação invocada no form da acção "recover_password"
  # => é a acção que trata efectivamente do envio do e-mail
  def send_password_recover_email
    @user = User.find_by_email(params[:user][:email])

    if @user.nil?
      flash[:notice] = "Não existem utilizadores com o endereço de e-mail que indicou."

      redirect_to :back
    else
      Emails.user_password_recover(@user).deliver

      flash[:notice] = "Foi enviado um e-mail para o endereço de e-mail que indicou.<br/><br/>Siga as instruções nele indicadas de forma a alterar a sua password de acesso."

      redirect_to root_path
    end
    
  end


  # GET
  # cria o formulário com os dados do utilizador (com token vindo do email)
  def edit_password
    # o utilizador é identificado pelo remember_token
    # esse remember token é enviado no link (?user=xxx) que é enviado para o utilizador para alteração da password

    @user = User.find_by_remember_token(params[:user])

    redirect_to root_path unless !@user.nil?
  end


  # PUT
  # faz o update da password
  def update_password
    # o e-mail do utilizador está colocado num campo hidden para poder identificar o utilizador que se está a editar
    @user = User.find_by_email(params[:user][:email])

    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.failed_password_attempt_count = 0;

    # guarda user na base de dados
    if @user.save
      # alerta para user criado com sucesso
      flash[:notice] = "A sua password foi alterada com sucesso."

      # autentica o user criado
      sign_in @user

      redirect_to root_path     

    else       
      render 'edit_password'
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
