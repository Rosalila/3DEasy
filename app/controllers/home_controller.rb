class HomeController < ApplicationController
  def index
    if current_user
      redirect_to printing_sets_path
    end
  end

  def subscribe
    email = params[:email]

    if !email =~ Devise.email_regexp
      return
      redirect_to root_url
    end

    email_subscription = EmailSubscription.new
    email_subscription.email = email
    email_subscription.key = SecureRandom.hex(25)
    email_subscription.confirmed = false
    email_subscription.save

    UserMailer.confirm_subscription_email(email_subscription).deliver_later

    redirect_to root_url
  end

  def confirm_subscription
    email = params[:email]
    key = params[:key]

    email_subscription = EmailSubscription.find_by(email: email, key: key)

    if !email_subscription
      return
      redirect_to root_url
    end

    email_subscription.confirmed = true
    email_subscription.save

    redirect_to root_url
  end

  def unsubscribe
    email = params[:email]
    key = params[:key]

    email_subscription = EmailSubscription.find_by(email: email, key: key)

    if !email_subscription
      return
      redirect_to root_url
    end

    email_subscription.destroy

    redirect_to root_url
  end
end
