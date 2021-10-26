class CarVariant < ApplicationRecord
  
  validates :variant, presence: true, allow_blank: false

  scope :car_variant_map, -> { all.pluck(:variant, :id) }

end
