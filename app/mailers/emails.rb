class Emails < ActionMailer::Base

  default from: "geral@douromemories.com"

  # configuração do envio do e-mail de confirmação de registo do utilizador no site
  # o corpo do e-mail é definido numa view
  def user_registration_confirmation(user)
  	@user = User.find(user.id)
  	mail(to: @user.email, subject: "Confirmacao do seu registo no site www.douromemories.com")
  end


  # configuração do envio do e-mail de confirmação da submissão de encomendas
  def order_submission_confirmation(user, order)
  	@user = User.find(user.id)
  	@order= Order.find(order.id)

  	mail(to: @user.email, subject: "Confirmacao da sua encomenda no site www.douromemories.com")
  end

end
