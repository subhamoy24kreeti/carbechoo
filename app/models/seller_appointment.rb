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
    values =[]
    q = ""
    i = 0
    params.each do |k, v|
      if i == 0
        q = "#{k} = ?"
      else
        q += " AND #{k} = ?"
      end
      values.append(v)
      i += 1
    end
    where('status = ?','approved').where(q, values)
  }

  def get_status_code
    statuses = { 'processing' => 0, 'investigating' => 1, 'approved' => 2, 'rejecting' => 3, 'sold out'=> 4 }
    return statuses[self.status]
  end

  def get_price
    if currency.blank?
      return '₹'+" "+price.to_s
    else
      return currency+" "+price.to_s
    end
  end
end
