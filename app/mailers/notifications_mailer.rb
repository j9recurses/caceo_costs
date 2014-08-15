class NotificationsMailer < ActionMailer::Base
  default :from => "emailcontact.q2.datauser@gmail.com"
  default :to => "emailcontact.q2.datauser@gmail.com"

  def new_message(message)
    @message = message
    mail(:from => @message.email, :subject => @message.message_subject)
    end
end
