class PrintingSet < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :printing_hub
  has_many :printables
  has_many :order_items
end

