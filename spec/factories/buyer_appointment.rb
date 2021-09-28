FactoryBot.define do
  factory :buyer_appointment do
    user_id {3}
    seller_appointment factory: :seller_appointment
  end
end