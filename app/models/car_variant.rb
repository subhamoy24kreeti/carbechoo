class CarVariant < ApplicationRecord
  
  validates :variant, presence: true, allow_blank: false

  scope :update_car_variant, ->(params) { where(id: params[:id]).update(variant: params[:variant]) }
  scope :car_variant_map, -> { all.pluck(:variant, :id) }

end
