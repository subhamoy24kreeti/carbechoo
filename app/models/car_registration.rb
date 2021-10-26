class CarRegistration < ApplicationRecord

  validates :state_code, presence: true, allow_blank: false

  scope :car_registration_map, -> { all.pluck(:state_code, :id) }
  
end
