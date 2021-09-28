FactoryBot.define do
  factory :seller_appointment do
    user_id {2}
    brand factory: :brand
    car_model factory: :car_model
    car_registration factory: :car_registration
    killometer_driven factory: :killometer_driven
    car_variant factory: :car_variant
    city factory: :city
    state factory: :state
    country factory: :country
    zip_code {'721305'}
    cost_range factory: :cost_range
    year_of_buy {'2021'}
    price {1545887}
    description {'it is a nice car'}
  end
end