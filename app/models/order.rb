class Order < ApplicationRecord
  belongs_to :order_state
  belongs_to :user
  belongs_to :shipping_type
  has_many :order_items
  belongs_to :printing_hub
end
