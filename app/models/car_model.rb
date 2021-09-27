class CarModel < ApplicationRecord

  belongs_to :brand
  validates :name, allow_blank: false, presence: true

end
