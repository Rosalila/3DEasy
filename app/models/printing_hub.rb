class PrintingHub < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :user_in_printing_hubs
  has_many :users, through: :user_in_printing_hubs
  has_many :printing_sets
  has_many :printers
  has_many :shipping_types
  has_many :orders, through: :printing_sets
  has_many :cart_items
  has_many :orders

  def has_printing_set printing_set
    return printing_sets.exists?(id: printing_set)
  end
end
