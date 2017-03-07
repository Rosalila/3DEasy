class Order < ApplicationRecord
  belongs_to :order_state
  belongs_to :user
  belongs_to :shipping_type
end
