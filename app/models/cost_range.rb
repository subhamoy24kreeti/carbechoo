class CostRange < ApplicationRecord

  validates :currency, presence: true, allow_blank: false
  validates :quality, presence: true, allow_blank: false
  validates :range1, presence: true, allow_blank: false
  validates :range2, presence: true, allow_blank: false
  validates :range2, numericality: { :greater_than => :range1 }

  scope :cost_range_map, -> { all.map {|cr| [cr.name, cr.id]} }

  def name
    currency+" "+range1.to_s+"-"+range2.to_s
  end

end
