class Brand < ApplicationRecord

  has_many :car_models, dependent: :destroy
  validates :brand_name, allow_blank: false, presence: true

  scope :update_brand, ->(params) { where(id: params[:id]).update(brand_name: params[:brand_name]) }

end