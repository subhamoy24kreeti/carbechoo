class User < ApplicationRecord
    has_secure_password
    enum role: {admin: "admin", seller: "seller", buyer: "buyer"}
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true
    validates_confirmation_of :password, :message=>"should match"
    def is_admin?
        return (self[:role].blank?)? false :(self[:role].eql?"admin")
    end

    def is_buyer?
        return (self[:role].blank?)? false :(self[:role].eql?"buyer")
    end

    def is_seller?
        return (self[:role].blank?)? false :(self[:role].eql?"seller")
    end

end
