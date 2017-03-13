class PrintingSetImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :printing_set
end
