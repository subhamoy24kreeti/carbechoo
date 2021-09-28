class SellerAppointment < ApplicationRecord
  has_many_attached :car_images, dependent: :destroy
  belongs_to :user
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :killometer_driven
  belongs_to :brand
  belongs_to :car_variant
  belongs_to :car_model
  belongs_to :cost_range, optional: true
  belongs_to :car_registration
  has_many :buyer_appointments

  validates :year_of_buy, presence: true, allow_blank: false
  validates :price, presence: true, allow_blank: false, numericality: true

  scope :search_filter, ->(search) {
    where('status = ?','approved').joins(:city, :killometer_driven, :state, :country, :car_variant, :car_model, :brand).where('cities.name LIKE :search OR killometer_drivens.killometer_range LIKE :search OR states.name LIKE :search OR countries.name LIKE :search OR car_variants.variant LIKE :search OR car_models.name LIKE :search OR brands.brand_name LIKE :search OR seller_appointments.zip_code LIKE :search', search: "%#{search}%")
  }

  scope :search_with_params_filter, ->(query, params){
    values =[]
    i = 0
    q = ""
    params.each do |k, v|
      if i == 0
        q = "#{k} = ?"
      else
        q += " AND #{k} = ?"
      end
      values.append(v)
      i += 1
    end
    search_filter(query).where(q, values)
  }

  scope :params_filter, ->(params){
    conditions = {}

    conditions[:city_id] = params[:city_id] if !params[:city_id].blank?
    conditions[:brand_id] =  params[:brand_id]  if !params[:brand_id].blank?
    conditions[:car_model_id] = params[:car_model_id] if !params[:car_model_id].blank?
    conditions[:year_of_buy] = params[:year_of_buy] if !params[:year_of_buy].blank?
    conditions[:car_variant_id] = params[:car_variant_id] if !params[:car_variant_id].blank?
    conditions[:car_registration_id] = params[:car_registration_id] if !params[:car_registration_id].blank?
    conditions[:killometer_driven_id] = params[:killometer_driven_id] if !params[:killometer_driven_id].blank?
    conditions[:cost_range_id] = params[:cost_range_id] if !params[:cost_range_id].blank?

    if !conditions.blank?
      if !params[:search].blank?
        where(status: 'approved').where(conditions).search_filter(params[:search])
      else
        where(status: 'approved').where(conditions)
      end
    else
      if !params[:search].blank?
        where(status: 'approved').where(conditions).search_filter(params[:search])
      else
        where(status: 'approved').where(conditions)
      end
    end
  }

  def get_status_code
    statuses = { 'processing' => 0, 'investigating' => 1, 'approved' => 2, 'rejecting' => 3, 'sold out'=> 4 }
    statuses[status]
  end

  def get_price
    if currency.blank?
      '₹'+" "+price.to_s
    else
      currency+" "+price.to_s
    end
  end
end
