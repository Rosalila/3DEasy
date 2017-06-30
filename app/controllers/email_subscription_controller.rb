class EmailSubscriptionController < ApplicationController
  def subscribe
    email = params[:email]

    if !email =~ Devise.email_regexp
      redirect_to root_url
      return
    end

    email_subscription = EmailSubscription.find_by(email: email)

    if email_subscription && email_subscription.confirmed
      redirect_to root_url
      return
    end

    if !email_subscription
      email_subscription = EmailSubscription.new
    end

    email_subscription.email = email
    email_subscription.key = SecureRandom.hex(25)
    email_subscription.confirmed = false
    email_subscription.save

    UserMailer.confirm_subscription_email(email_subscription).deliver_later
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
  end
end
