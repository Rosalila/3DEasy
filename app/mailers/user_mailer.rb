class UserMailer < ApplicationMailer
  default :from => "3DEasy.co <automated@3deasy.co>"

  def welcome_email(user)
    @user = user
    @url  = "http://3deasy.co/users/sign_in"
    mail(:to => user.email, :subject => "Welcome to 3DEasy.co")
  end

  def confirm_subscription_email(user_subscription)
    @email = user_subscription.email
    @key = user_subscription.key
    @url = "http://3deasy.co/confirm_subscription?email=" + @email + "&key=" + @key
    mail(:to => @email, :subject => "Email confirmation")
  end
end
