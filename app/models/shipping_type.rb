class ShippingType < ApplicationRecord
  belongs_to :printing_hub
  has_many :orders
end
