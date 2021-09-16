class State < ApplicationRecord
    belongs_to :country 
    has_many :cities, :dependent => :destroy
    validates :name, presence: true, allow_blank: false
end
