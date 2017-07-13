class AddUnsubscribedToEmailSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :email_subscriptions, :unsubscribed, :boolean
  end
end
