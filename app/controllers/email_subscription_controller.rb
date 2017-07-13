class EmailSubscriptionController < ApplicationController
  def subscribe
    email = params[:email]

    if !email =~ Devise.email_regexp
      redirect_to root_url
      return
    end

    @subscription_state = ""

    email_subscription = EmailSubscription.find_by(email: email)

    if email_subscription
      if email_subscription.unsubscribed
        @subscription_state = "unsubscribed"
        return
      elsif email_subscription.confirmed
        @subscription_state = "already confirmed"
        return
      else
        @subscription_state = "error"
        return
      end
    end

    if !email_subscription
      email_subscription = EmailSubscription.new
    end

    email_subscription.email = email
    email_subscription.key = SecureRandom.hex(25)
    email_subscription.confirmed = false
    email_subscription.unsubscribed = false
    email_subscription.save

    UserMailer.confirm_subscription_email(email_subscription).deliver_later

    @subscription_state = "just subscribed"
  end

  def confirm_subscription
    email = params[:email]
    key = params[:key]

    @confirm_state = ""

    email_subscription = EmailSubscription.find_by(email: email, key: key)

    if !email_subscription
      @confirm_state = "error"
      return
    end

    email_subscription.confirmed = true
    email_subscription.unsubscribed = false
    email_subscription.save

    @confirm_state = "just confirmed"
  end

  def unsubscribe
    email = params[:email]
    key = params[:key]

    @unsubscribe_state = ""

    email_subscription = EmailSubscription.find_by(email: email, key: key)

    if !email_subscription
      @unsubscribe_state = "error"
      return
    end

    email_subscription.confirmed = true
    email_subscription.unsubscribed = true
    email_subscription.save

    @unsubscribe_state = "just unsubscribed"
  end
end
