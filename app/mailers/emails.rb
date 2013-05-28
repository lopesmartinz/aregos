class Emails < ActionMailer::Base
  default from: "from@example.com"

  def user_registration_confirmation(user)  	
  	@user = user
  	mail(to: user.email, subject: "assunto")
  end
end
