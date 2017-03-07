class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :printing_set
end
