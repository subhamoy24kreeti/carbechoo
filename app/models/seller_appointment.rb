class SellerAppointment < ApplicationRecord
    has_many :car_images, dependent: :destroy
    belongs_to :user
    belongs_to :city
    belongs_to :state
    belongs_to :country
    belongs_to :killometer_driven
    belongs_to :brand
    belongs_to :variant
end
