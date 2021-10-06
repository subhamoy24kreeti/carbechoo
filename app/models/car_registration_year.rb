class CarRegistrationYear < ApplicationRecord

  validates_numericality_of :range2, :greater_than => :range1

  scope :update_car_registion_year, ->(params) { where(id: params[:id]).update(range1: params[:range1], range2: params[:range2]) }

  def year_map
    car_registration_year = CarRegistrationYear.first()
    years = []
    if !car_registration_year.blank?
      for year in car_registration_year.range1..car_registration_year.range2
        years.append([year, year])
      end
    end
    years
  end
end
