# encoding: utf-8

class Emails < ActionMailer::Base

  default from: "geral@douromemories.com"

  # configuração do envio do e-mail de confirmação de registo do utilizador no site
  # o corpo do e-mail é definido numa view
  def user_registration_confirmation(user)
  	@user = User.find(user.id)
  	mail(to: @user.email, subject: "Confirmação do seu registo no site www.douromemories.com")
  end


  # recuperação da password
  def user_password_recover(user)
    @user = user

    mail(to: @user.email, subject: "Pedido de alteração de password de acesso ao site www.douromemories.com")
  end


  # configuração do envio do e-mail de confirmação da submissão de encomendas
  def order_submission_confirmation(user, order)
  	@user = User.find(user.id)
  	@order= Order.find(order.id)

  	mail(to: @user.email, subject: "Confirmação da sua encomenda no site www.douromemories.com")
  end


  # configuração do envio do e-mail de confirmação da submissão de encomendas
  def general_interaction_submission(general_interaction)
    @general_interaction = general_interaction

    #mail(to: "geral@douromemories.com", subject: "Mensagem de Contacto do site www.douromemories.com")
    mail(to: "lopesmartinz@gmail.com", subject: "Mensagem de Contacto do site www.douromemories.com")
  end

end
