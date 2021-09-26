FactoryBot.define do
    factory :state do
        name {"west bengal"}
        country factory: :country
    end
end