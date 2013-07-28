class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :password, :password_confirmation, :failed_password_attempt_count

  # ATENÇÃO - o atributo "is_failed_password_attempt_count_update"
  # => foi criado para que se possa evitar as validações quando
  # =>  se tenta incrementar o número de tentativas falhadas
  attr_accessor :is_failed_password_attempt_count_update
  
  # "has_secure_password" repesenta o campo "password_digest"
  has_secure_password



  ##################################
  #### RELAÇÕES COM OUTRAS TABELAS
  ##################################  

  has_many :orders, :dependent => :destroy



  ##################################
  #### OPERAÇÕES ANTES DO INSERT
  ##################################

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token



  ##################################
  #### VALIDAÇÕES
  ##################################


  # ATENÇÃO - As validações da password não são feitas quando estamos a actualizar o número de logins falhados
  validates_presence_of :name

          validates_length_of :name,
            :maximum => 50,
            :if => Proc.new { |u| u.name.present? }

  
  VALID_EMAIL_REGEX = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :email

          validates_format_of :email,
            :with => VALID_EMAIL_REGEX,
            :if => Proc.new { |u| u.email.present? }

          validates_uniqueness_of :email,
            :case_sensitive => false,
            :if => Proc.new { |u| u.email.present? }

# ATENÇÃO - só se valida a password se não estivermos a actualizar o número de logins falhados
  VALID_PASSWORD_REGEX = /^(?=.*[a-zA-Z])(?=.*[0-9]).*$/
  validates_presence_of :password,
    :if => Proc.new { |u| !u.is_failed_password_attempt_count_update == true }

          validates_length_of :password,
            :minimum => 6,
            :if => Proc.new { |u|u.password.present? }

          validates_format_of :password,
          :with => VALID_PASSWORD_REGEX,
            :if => Proc.new { |u| u.password.present? }


  
  after_validation :delete_useless_error_messages



  ##################################
  #### MÉTODOS PRIVADOS
  ##################################

  private
  # criar identificador único para o utilizador (além do id)
  def create_remember_token
    # o token é criado sempre que há um update do user
    # => possibilita por exemplo que após a recuperação de password o mesmo link
    # => (que identifica o utlizador pelo remember_token) não possa voltar a ser utilizado
    self.remember_token = SecureRandom.urlsafe_base64
  end

  
  # apaga as mensagens de erro que não fizerem sentido
  def delete_useless_error_messages
    # remover a mensagem relativa à password_digest
    errors.delete(:password_digest)
  end

end
