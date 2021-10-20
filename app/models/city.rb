class City < ApplicationRecord
  
  belongs_to :state
  has_one :country, through: :state

  validates :name, allow_blank: false, presence: true

  scope :update_city, ->(params) { where(id: params[:id]).update(state_id: params[:state_id], name: params[:name] )}
  scope :city_map, ->(state_id) { where(state_id: state_id ).pluck(:name, :id) }
  scope :all_city_map, -> { all.pluck(:name, :id)}

end
