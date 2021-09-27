class CarRegistrationYear < ApplicationRecord

  validates_numericality_of :range2, :greater_than => :range1

end
