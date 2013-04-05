class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :password, :password_confirmation
  
  # "has_secure_password" repesenta o campo "password_digest"
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  #validações
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  # "private" é para funções que só serão usadas
  # => dentro do contexto da própria classe
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
