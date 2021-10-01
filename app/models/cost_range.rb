class CostRange < ApplicationRecord

  validates :currency, presence: true, allow_blank: false
  validates :quality, presence: true, allow_blank: false
  validates :range1, presence: true, allow_blank: false
  validates :range2, presence: true, allow_blank: false

  validates :range2, numericality: {:greater_than => :range1}

  scope :update_cost_range, ->(params) { where(id: params[:id]).update(quality: params[:quality], range1: params[:range1], range2: params[:range2], currency: params[:currency] ) }
  def name
    currency+" "+range1.to_s+"-"+range2.to_s
  end

end
