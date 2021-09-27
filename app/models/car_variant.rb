class CarVariant < ApplicationRecord
  validates :variant, presence: true, allow_blank: false
end
