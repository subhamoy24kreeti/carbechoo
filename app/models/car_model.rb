class CarModel < ApplicationRecord

  belongs_to :brand
  validates :name, allow_blank: false, presence: true

  scope :get_car_models_by_brand, ->(params) { where(brand_id: params[:brand_id]) }
  scope :car_model_map, -> { all.pluck(:name, :id) }
  
end
