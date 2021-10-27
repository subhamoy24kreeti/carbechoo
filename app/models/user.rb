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
  belongs_to :city, optional: true
  belongs_to :state, optional: true
  belongs_to :country, optional: true

  after_validation :address_settings
  before_create :confirmation_email_token
  after_update :email_verification_mail
  after_create :user_creation_mails

  scope :admins, -> { where(role: 'admin') }
  scope :buyers, -> { where(role: 'buyer') }
  scope :sellers, -> { where(role: 'seller') }
  scope :update_password, ->(params) { update(password: params[:password], password_confirmation: params[:password_confirmation], password_reset_token: nil, password_reset_token_sent_at: nil) }
  scope :seller_with_offset, ->(offset) { limit(10).offset(offset).where(role: 'seller') }
  scope :nearest_seller, ->(longitude, latitude){
    radius = 100
    lng_min = (longitude - radius / (Math.cos(latitude/ 180.0 * Math::PI) * 69).abs)
    lng_max = (longitude + radius / (Math.cos(latitude/ 180.0 * Math::PI) * 69).abs)
    lat_min = (latitude - (radius / 69))
    lat_max = (latitude + (radius / 69))
    where('role = ?','seller').where('longitude >= ?', lng_min).where('longitude <= ?', lng_max).where('latitude >= ?', lat_min).where('latitude <= ?', lat_max);
  }

  def is_admin?
    (role.blank?)? false :(role.eql?"admin")
  end

  def is_buyer?
    (role.blank?)? false :(role.eql?"buyer")
  end

  def is_seller?
    (role.blank?)? false :(role.eql?"seller")
  end

  def full_name
    first_name+" "+last_name
  end

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
    write_attribute(:email_confirmed, true)
    write_attribute(:confirm_token_email, nil)
    save
  end

  def user_profile_update(params)
    if email != params[:email]
      @updating_email =  true
    end

    if !params[:phone].blank?
      if(params[:phone] != user.phone)
        @updating_phone = true
      end
    end

    update(params)
  end

  def email_verification_key_set
    self.confirm_token_email = SecureRandom.urlsafe_base64.to_s
    if save
      UserMailer.email_verification_mail(self).deliver_now
      true
    else
      false
    end
  end

  def forget_password_key_set
    self.password_reset_token_make = true
    self.password_reset_token = SecureRandom.urlsafe_base64.to_s
    self.password_reset_token_sent_at = Time.now
    if save
      UserMailer.forget_password_change_mail(self).deliver
      true
    else
      false
    end
  end

  private

  def confirmation_email_token
    if email_changed? || new_record? || email_verification_token_request?
      write_attribute(:confirm_token_email, SecureRandom.urlsafe_base64.to_s)
    end
  end

  def confirmation_phone_token
    if !email.blank? && elf.confirmation_phone_token.blank?
      write_attribute(:confirmation_phone_token, SecureRandom.urlsafe_base64.to_s)
    end
  end

  def address_settings
    if !city_id.blank? && !state_id.blank? && !country_id.blank?
      city = City.find(city_id)
      state = State.find(state_id)
      country = Country.find(country_id)
      address = [city.name, state.name, zip_code, country.name].compact.join(', ')
      write_attribute(:address, address)
      p = Geocoder.search(address);
      if !p.blank?
        write_attribute(:longitude, p[0].data['lon'])
        write_attribute(:latitude, p[0].data['lat'])
      end
      Rails.logger.info(p)
      Rails.logger.info(address)
    end
  end

  def email_verification_mail
    if(updating_email)
      Rails.logger.info(email)
      UserMailer.email_verification_mail(self).deliver
    end
  end

  def user_creation_mails
    if role == 'seller'
      SellerMailer.welcome_mail(self).deliver
      UserMailer.email_verification_mail(self).deliver
    elsif role == 'buyer'
      BuyerMailer.welcome_mail(self).deliver
      UserMailer.email_verification_mail(self).deliver
    end
  end
end
