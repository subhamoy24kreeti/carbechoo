FactoryBot.define do
  factory :car_model do
    name {"kharagpur"}
    brand factory: :brand
  end
end