class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :printing_set
end
