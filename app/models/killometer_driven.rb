class KillometerDriven < ApplicationRecord

  validates :killometer_range, presence: true, allow_blank: false

  scope :update_killometer_driven, ->(params) { where(id: params[:id]).update(killometer_range: params[:killometer_range]) }
  scope :killometer_driven_map, -> { all.pluck(:killometer_range, :id) }
  
end
