class State < ApplicationRecord
	belongs_to :country
	has_many :cities, :dependent => :destroy
  
	validates :name, presence: true, allow_blank: false

  scope :update_state, ->(params) { where(id: params[:id]).update(name: params[:name], country_id: params[:country_id]) }
  scope :state_map, ->(country_id) { where(country_id: country_id ).pluck(:name, :id) }
  scope :all_state_map, -> { all.pluck(:name, :id) }
  scope :get_cities, ->(state_id) { find(state_id).cities }

end
