module SessionsHelper
	
	# guarda cookie com o remember token do utilizador actual
	def sign_in (user)
		remember_token = user.remember_token
		cookies.permanent[:aregos_user_id] = remember_token

		# define o utilizador como sendo o user actual
		# tem que especifar o self para se referir
		# =>  ao método que existe no helper
		# =>  e não à criação de uma variável local
		self.current_user = user
	end


	# "SET" do utilizador actual (se estiver autenticado)
	def current_user=(user)
		@current_user = user
	end


	# "GET" do utilizador actual
	def current_user
		if !cookies[:aregos_user_id].nil?			
			# só verifica o user pelo token se ainda não estiver definido
			@current_user ||= User.find_by_remember_token(cookies[:aregos_user_id])
		end
  	end


  	# verifica se o utilizador está autenticado
	def user_is_signed_in?
		!current_user.nil?
  	end


  	# verifica se user autenticado tem acesso a uma determinada página
	def is_allowed_user (allowed_user)
		current_user == allowed_user
	end


	# faz logout do utilizador
	def sign_out
		self.current_user = nil
		cookies.delete(:aregos_user_id)
	end

end
