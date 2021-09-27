class User < ApplicationRecord
  attr_accessor :updating_password
  attr_accessor :updating_email
  attr_accessor :password_reset_token_make
  attr_accessor :email_verification_token_make

  def initialize(user)
    super
    @updating_email = false
    @updating_password = false
    @password_reset_token_make = false
    @email_verification_token_make = false
  end

  has_secure_password
  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :email, format: { with: /\b[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\z/ }, uniqueness: { case_sensitive: false }
  validates :phone, numericality: true, length: { minimum: 10, maximum: 15 }, allow_blank: true, presence: false
  validates :password, presence: true, allow_blank: false, confirmation: true, length: {in: 6..20}, if: :password_changed?
  validates_confirmation_of :password, message: "password should match with confirmation", if: :password_changed?

  has_many :seller_appointments, :dependent => :destroy
  has_many :buyer_appointments, :dependent => :destroy
  has_many :cities, :through => :seller_appointments

  has_one_attached :cover_pic, :dependent => :destroy
  has_one_attached :profile_pic, :dependent => :destroy

  belongs_to :city
  belongs_to :state
  belongs_to :country

  after_validation :address_settings

  before_save :confirmation_email_token
  before_save :password_reset_token_generate, if: :password_reset_token_request?

  def is_admin?
    (role.blank?)? false :(role.eql?"admin")
  end

  def is_buyer?
    (role.blank?)? false :(role.eql?"buyer")
  end

  def is_seller?
    return (role.blank?)? false :(role.eql?"seller")
  end

  def full_name
    return first_name+" "+last_name
  end

  scope :nearest_seller, ->(longitude, latitude){
    radius = 100
    lng_min = (longitude - radius / (Math.cos(latitude/ 180.0 * Math::PI) * 69).abs)
    lng_max = (longitude + radius / (Math.cos(latitude/ 180.0 * Math::PI) * 69).abs)
    lat_min = (latitude - (radius / 69))
    lat_max = (latitude + (radius / 69))
    where('role = ?','seller').where('longitude >= ?', lng_min).where('longitude <= ?', lng_max).where('latitude >= ?', lat_min).where('latitude <= ?', lat_max);
  }

  def password_changed?
    updating_password || new_record?
  end

  def email_changed?
    updating_email || new_record?
  end

  def buyer_appointment_exists(seller_appointment_id)
    buyer_appointments.exists?(seller_appointment_id: seller_appointment_id )
  end

  def phone_present_changed?
    !phone.blank?
  end

  def password_reset_token_request?
    password_reset_token_make
  end

  def email_verification_token_request?
    email_verification_token_make
  end

  def activate_email
    self.email_confirmed = true
    self.confirm_token_email = nil
    save
  end


  private

  def password_reset_token_generate
    self.password_reset_token = SecureRandom.urlsafe_base64.to_s
    self.password_reset_token_sent_at = Time.now
  end

  def confirmation_email_token
    if email_changed? || new_record? || email_verification_token_request?
      self.confirm_token_email = SecureRandom.urlsafe_base64.to_s
    end
  end

  def confirmation_phone_token
    if !email.blank? && elf.confirmation_phone_token.blank?
      self.confirmation_phone_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def address_settings
    if !self.city_id.blank? && !self.state_id.blank? && !self.country_id.blank?
      city = City.find(self.city_id)
      state = State.find(self.state_id)
      country = Country.find(self.country_id)
      self.address = [city.name, state.name, zip_code, country.name].compact.join(', ')
      p = Geocoder.search(address);
      if !p.blank?
        self.longitude = p[0].data['lon']
        self.latitude  = p[0].data['lat']
      end
      Rails.logger.info(p)
      Rails.logger.info(address)
    end
  end
end