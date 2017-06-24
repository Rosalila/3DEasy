class UserMailer < ApplicationMailer
  default :from => "3DEasy.co <automated@3deasy.co>"

  def welcome_email(user)
    @user = user
    @url  = "http://3deasy.co/users/sign_in"
    mail(:from => "3DEasy.co <automated@3deasy.co>", :to => user.email, :subject => "Welcome to 3dEasy.co")
  end
end
