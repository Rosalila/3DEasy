class Order < ApplicationRecord
  belongs_to :order_state
  belongs_to :user
  belongs_to :shipping_type
  has_many :order_items
  belongs_to :printing_hub

  def doge_deposits
    client = DogecoinClient.new
    if client.valid?
      return client.get_received_by_address(doge_address)
    else
      return 0
    end
  end

  def doge_deposits_unconfirmed
    client = DogecoinClient.new
    if client.valid? and doge_address
      return client.get_received_by_address(doge_address,0)
    else
      return 0
    end
  end
end
