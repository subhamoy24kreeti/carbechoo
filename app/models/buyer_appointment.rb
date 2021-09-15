class BuyerAppointment < ApplicationRecord
    belongs_to :user
    belongs_to :seller_user, class_name: "User", foreign_key: "seller_user_id"
end
