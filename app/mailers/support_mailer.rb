class SupportMailer < ActionMailer::Base
  default from: "emailcontact.q2.datauser@gmail.com"
  default to: "contact.caceoelectioncosts@gmail.com"


  def signup_notification(user)
    @user = user
    @county = CaCountyInfo.find(@user.county)
    
    mail subject: "New User Signup: #{@user.email}"
  end
end
