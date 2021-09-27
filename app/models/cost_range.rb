class CostRange < ApplicationRecord

  validates :currency, presence: true, allow_blank: false
  validates :range1, presence: true, allow_blank: false
  validates :range2, presence: true, allow_blank: false

  validates :range2, numericality: {:greater_than => :range1}

  def name
    return self.currency+" "+self.range1.to_s+"-"+self.range2.to_s
  end

end
