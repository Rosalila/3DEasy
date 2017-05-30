class PrintingSet < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :printing_hub
  has_many :printables
  has_many :order_items
  has_many :printing_set_images

  def id_and_paramterized_name
    return self.id.to_s + "-" + self.name.parameterize
  end

  def get_price cupon
    if cupon
      return (doges * (1.0-cupon.discount/100.0)).round(8)
    end
    return doges
  end

  def get_cupon cupon_code
    return printing_hub.cupons.find_by_code(cupon_code)
  end

end

