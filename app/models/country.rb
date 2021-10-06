class Country < ApplicationRecord
  has_many :states, :dependent => :destroy
  validates :name, presence: true, allow_blank: false

  scope :update_country, ->(params) { where(id: params[:id]).update(name: params[:name]) }

  scope :get_states, ->(params) { includes(:states).find(params[:country_id]).states }

  scope :get_country_map, -> { all.pluck(:name, :id) }
end
