class CarRegistration < ApplicationRecord
  validates :state_code, presence: true, allow_blank: false
end
