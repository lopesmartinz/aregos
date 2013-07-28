class GeneralInteraction < ActiveRecord::Base

	attr_accessible :sender_name, :sender_email, :subject, :description



	##################################
	#### VALIDAÇÕES
	##################################

	VALID_EMAIL_REGEX = /\A[\w+\-._]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates_presence_of :sender_email

          validates_format_of :sender_email,
            :with => VALID_EMAIL_REGEX,
            :if => Proc.new { |gi| gi.sender_email.present? }


  	validates_presence_of :subject
  	validates_presence_of :description

end
