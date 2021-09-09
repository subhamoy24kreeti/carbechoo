class User < ApplicationRecord
    before_create :confirmation_email_token
    has_secure_password
    enum role: {admin: "admin", seller: "seller", buyer: "buyer"}
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true
    validates_confirmation_of :password, :message=>"should match"

    has_many :seller_appointments
    has_many :cities, :through => :seller_appointments

    
    after_validation :address_settings

    def is_admin?
        return (self[:role].blank?)? false :(self[:role].eql?"admin")
    end

    def is_buyer?
        return (self[:role].blank?)? false :(self[:role].eql?"buyer")
    end

    def is_seller?
        return (self[:role].blank?)? false :(self[:role].eql?"seller")
    end

    def activate_email
        self.email_confirmed = true
        self.confirm_token_email = nil
        save
    end

    private
    def confirmation_email_token
        if self.confirm_token_email.blank?
            self.confirm_token_email = SecureRandom.urlsafe_base64.to_s
        end
    end

    def confirmation_phone_token
        if self.confirmation_phone_token.blank?
            self.confirmation_phone_token = SecureRandom.urlsafe_base64.to_s
        end
    end

    def address
        return [city, state, zip_code, country].compact.join(', ')
    end
    
    def address_settings
        if !self.city.blank? && !self.state.blank? && !self.country.blank?
            p = Geocoder.search(self.address);
            if !p.blank?
                self.longitude = p[0].data['lon']
                self.latitude  = p[0].data['lat']
            end
        end
    end
end