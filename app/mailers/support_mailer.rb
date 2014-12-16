class SupportMailer < ActionMailer::Base
  default from: "automated.caceoelectioncosts@gmail.com" 
  default to: "contact.caceoelectioncosts@gmail.com"

  def signup_notification(user)
    @user = user
    @county = user.county
    mail subject: "New User Signup: #{@user.email}"
  end

  def contact_us(message)
    @message = message
    mail(:from => @message.email, :subject => "Contact Us: #{@message.message_subject}")
  end
end
