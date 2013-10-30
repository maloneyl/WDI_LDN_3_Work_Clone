class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def registration_confirmation(user)
    @user = user # this is so user_mailer view can access the user
    mail to: user.email, subject: "Your MailerApp registration"
  end

end
