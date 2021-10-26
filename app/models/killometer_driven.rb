class KillometerDriven < ApplicationRecord

  validates :killometer_range, presence: true, allow_blank: false

  scope :killometer_driven_map, -> { all.pluck(:killometer_range, :id) }
  
end
