FactoryBot.define do
  factory :user do
    first_name {"subhamoy"}
    last_name {'das'}
    email {'subuamoydas24@gmail.com'}
    password {'passpass'}
    password_confirmation {'passpass'}
    city factory: :city
    state factory: :state
    country factory: :country
    zip_code {'721305'}
    role {'seller'}
  end
end