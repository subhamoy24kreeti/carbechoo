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
  
  after_create :appointment_creation_mail

  scope :search_filter, ->(search) {
    where(status: 'approved').joins(:city, :killometer_driven, :state, :country, :car_variant, :car_model, :brand).where('cities.name LIKE :search OR killometer_drivens.killometer_range LIKE :search OR states.name LIKE :search OR countries.name LIKE :search OR car_variants.variant LIKE :search OR car_models.name LIKE :search OR brands.brand_name LIKE :search OR seller_appointments.zip_code LIKE :search', search: "%#{search}%")
  }

  scope :recent_processing_appointments, ->(user) {
    limit(5).where(user_id: user.id, status: 'processing').order('updated_at DESC')
  }

  scope :recent_investigating_appointments, ->(user)  {
    limit(5).where(user_id: user.id, status: 'investigating').order('updated_at DESC')
  }

  scope :recent_approved_appointments, ->(user) {
    limit(5).where(user_id: user.id, status: 'approved').order('updated_at DESC')
  }

  scope :params_filter, ->(params){
    page = 0
    if( !params[:page].blank?)
      page = params[:page]
    end
    conditions = {}

    conditions[:city_id] = params[:city_id] if !params[:city_id].blank?
    conditions[:brand_id] =  params[:brand_id]  if !params[:brand_id].blank?
    conditions[:car_model_id] = params[:car_model_id] if !params[:car_model_id].blank?
    conditions[:year_of_buy] = params[:year_of_buy] if !params[:year_of_buy].blank?
    conditions[:car_variant_id] = params[:car_variant_id] if !params[:car_variant_id].blank?
    conditions[:car_registration_id] = params[:car_registration_id] if !params[:car_registration_id].blank?
    conditions[:killometer_driven_id] = params[:killometer_driven_id] if !params[:killometer_driven_id].blank?
    conditions[:cost_range_id] = params[:cost_range_id] if !params[:cost_range_id].blank?

    if !params[:search].blank?
      offset(page*10).limit(10).where(status: 'approved').where(conditions).search_filter(params[:search])
    else
      offset(page*10).limit(10).where(status: 'approved').where(conditions)
    end
  }

  scope :cars, ->{ where(status: 'approved').order('updated_at DESC') }
  scope :seller_appointments, ->(user_id) { where(user_id: user_id) }
  scope :latest_seller_cars, ->(params) { limit(5).where(user_id: params[:id], status: 'approved').order('updated_at DESC') }

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

  def update_seller_appointment(params)
    check = false
    if status != params[:status]
      check = true
    end

    if update(params)
      if check
        SellerMailer.appointment_updates_mail(self).deliver
      end
      true
    else
      false
    end
  end

  private

  def appointment_creation_mail
    SellerMailer.appointment_submission_mail(user, id).deliver
  end
end

