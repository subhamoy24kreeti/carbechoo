class CarRegistrationYear < ApplicationRecord

  validates_numericality_of :range2, :greater_than => :range1

  scope :update_car_registion_year, ->(params) { where(id: params[:id]).update(range1: params[:range1], range2: params[:range2]) }

end
