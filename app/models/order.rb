class Order < ApplicationRecord
  belongs_to :order_state
  belongs_to :user
  belongs_to :shipping_type
  has_many :order_items
  belongs_to :printing_hub

  def doge_deposits
    client = DogecoinClient.new
    if client.valid?
      return client.get_balance(doge_address)
    else
      return -1
    end
  end
end
