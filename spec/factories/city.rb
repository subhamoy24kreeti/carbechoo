FactoryBot.define do
  factory :city do
    name {"kharagpur"}
    state factory: :state
  end
end