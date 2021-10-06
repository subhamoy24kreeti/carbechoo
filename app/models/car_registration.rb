class CarRegistration < ApplicationRecord
  validates :state_code, presence: true, allow_blank: false

  scope :update_car_registration, ->(params) { where(id: params[:id]).update(state_code: params[:state_code]) }

  scope :car_registration_map, -> { all.pluck(:state_code, :id) }
end
