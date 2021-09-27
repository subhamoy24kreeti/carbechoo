class City < ApplicationRecord
  belongs_to :state
  has_one :country, through: :state
  validates :name, allow_blank: false, presence: true
end
