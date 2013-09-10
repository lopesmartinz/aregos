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
  def general_interaction_submission(general_interaction)
    @general_interaction = general_interaction

    #mail(to: "geral@douromemories.com", subject: "Mensagem de Contacto do site www.douromemories.com")
    mail(to: "lopesmartinz@gmail.com", subject: "Mensagem de Contacto do site www.douromemories.com")
  end

  # configuração do envio do e-mail de confirmação da submissão de encomendas
  def order_creation(user, order)
    @user = User.find(user.id)
    @order= Order.find(order.id)

    mail(to: @user.email, subject: "www.douromemories.com | Encomenda Registada | Código da Encomenda: #{order.reference}")
  end

  # configuração do envio do e-mail de confirmação do pagamento
  def order_payment_received(user, order)
    @user = User.find(user.id)
    @order= Order.find(order.id)

    mail(to: @user.email, subject: "www.douromemories.com | Pagamento Recebido | Código da Encomenda: #{order.reference}")
  end

  # configuração do envio do e-mail de início do processamento da encomenda
  def order_process_start(user, order)
    @user = User.find(user.id)
    @order= Order.find(order.id)

    mail(to: @user.email, subject: "www.douromemories.com | Encomenda em Processamento | Código da Encomenda: #{order.reference}")
  end

  # configuração do envio do e-mail de confirmação do envio da encomenda
  def order_sent(user, order)
    @user = User.find(user.id)
    @order= Order.find(order.id)

    mail(to: @user.email, subject: "www.douromemories.com | Encomenda Enviada | Código da Encomenda: #{order.reference}")
  end

  # configuração do envio do e-mail de conclusão da encomenda
  def order_closed(user, order)
    @user = User.find(user.id)
    @order= Order.find(order.id)

    mail(to: @user.email, subject: "www.douromemories.com | Encomenda Concluída | Código da Encomenda: #{order.reference}")
  end

end
