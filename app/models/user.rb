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
    enum role: {admin: "admin", seller: "seller", buyer: "buyer"}
    validates :first_name, presence: true, allow_blank: false
    validates :last_name, presence: true, allow_blank: false
    validates :email, presence: true, allow_blank: false, uniqueness: { case_sensitive: false }, if: :email_changed?
    validates :phone, numericality: true, allow_blank: false, length: {minimum: 10, maximum: 15}, if: :phone_present_changed?

    validates :password, presence: true, allow_blank: false, confirmation: true, length: {in: 6..20}, if: :password_changed?
    validates_confirmation_of :password, message: "should match", if: :password_changed?

    

    has_many :seller_appointments, :dependent => :destroy
    has_many :buyer_appointments, :dependent => :destroy
    has_many :buyer_appointments_seller, class_name: "BuyerAppointment", foreign_key: "seller_user_id", :dependent => :destroy
    
    has_many :cities, :through => :seller_appointments

    has_one_attached :cover_pic, :dependent => :destroy
    has_one_attached :profile_pic, :dependent => :destroy

    
    after_validation :address_settings

    before_save :confirmation_email_token
    before_save :password_reset_token_generate, if: :password_reset_token_request?

    def is_admin?
        return (self[:role].blank?)? false :(self[:role].eql?"admin")
    end

    def is_buyer?
        return (self[:role].blank?)? false :(self[:role].eql?"buyer")
    end

    def is_seller?
        return (self[:role].blank?)? false :(self[:role].eql?"seller")
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

    def address
        return [city, state, zip_code, country].compact.join(', ')
    end

    private

    def password_reset_token_generate
        self.password_reset_token = SecureRandom.urlsafe_base64.to_s
        self.password_reset_token_sent_at = Time.now
    end

    def confirmation_email_token
        Rails.logger.info("pop")
        Rails.logger.info(updating_email)
        Rails.logger.info(password)
        Rails.logger.info("popi")
        
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
        if !self.city.blank? && !self.state.blank? && !self.country.blank?
            p = Geocoder.search(self.address);
            if !p.blank?
                self.longitude = p[0].data['lon']
                self.latitude  = p[0].data['lat']
            end
            Rails.logger.info(p)
            Rails.logger.info(self.address)
        end
    end
end