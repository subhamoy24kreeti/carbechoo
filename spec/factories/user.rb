FactoryBot.define do
    factory :user do
        first_name {"subhamoy"}
        last_name {'das'}
        email {'subuamoydas24@gmail.com'}
        password {'passpass'}
        password_confirmation {'passpass'}
        city {'kharagpur'}
        state {'west bengal'}
        country {'india'}
        zip_code {'721305'}
        role {'seller'}
    end
end