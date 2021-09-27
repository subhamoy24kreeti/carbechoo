class KillometerDriven < ApplicationRecord
  validates :killometer_range, presence: true, allow_blank: false

end
