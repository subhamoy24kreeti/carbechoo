class CarModel < ApplicationRecord

  belongs_to :brand
  validates :name, allow_blank: false, presence: true

  scope :update_car_model, ->(params) { where(id: params[:id]).update(brand_id: params[:brand_id], name: params[:name]) }
  scope :get_car_models_by_brand, ->(params) { where(brand_id: params[:brand_id]) }
end
