class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :password, :password_confirmation
  
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


  validates_presence_of :password

          validates_length_of :password,
            :minimum => 6,
            :if => Proc.new { |u| u.password.present? }


  
  after_validation :delete_useless_error_messages



  ##################################
  #### MÉTODOS PRIVADOS
  ##################################

  private
  # criar identificador único para o utilizador (além do id)
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  
  # apaga as mensagens de erro que não fizerem sentido
  def delete_useless_error_messages
    # remover a mensagem relativa à password_digest
    errors.delete(:password_digest)
  end

end
