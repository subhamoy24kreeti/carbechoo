class CarRegistrationYear < ApplicationRecord
  validates_numericality_of :range2, greater_than: :range1

  def self.year_map
    car_registration_year = CarRegistrationYear.first
    years = []
    if !car_registration_year.blank?
      for year in car_registration_year.range1..car_registration_year.range2
        years.append([year, year])
      end
    end
    years
  end
end

