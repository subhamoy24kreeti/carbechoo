class Country < ApplicationRecord
  has_many :states, :dependent => :destroy
  validates :name, presence: true, allow_blank: false
end
