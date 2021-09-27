class Brand < ApplicationRecord

  has_many :car_models, dependent: :destroy
  validates :brand_name, allow_blank: false, presence: true

end