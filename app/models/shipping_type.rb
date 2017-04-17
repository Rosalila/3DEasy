class ShippingType < ApplicationRecord
  belongs_to :printing_hub
  has_many :orders

  def name_with_price
    return name + " Ð" + doges.to_s
  end
end
