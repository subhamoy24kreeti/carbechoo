namespace :admin do
    resources :admin
    resources :car_model
    resources :brand
    resources :car_registration
    resources :car_variant
    resources :city
    resources :killometer_driven
    resources :seller_appointment
    resources :buyer_appointment
    post "brand/create", to:"brand#create", as: 'brand_create'
    post "car-registration/create", to:"car_registration#create", as: 'car_registration_create'
    post "car-model/create", to:"car_model#create", as: 'car_model_create'
    post "killometer-driven/create", to:"killometer_driven#create", as: 'killometer_driven_create'
    post "city/create", to:"city#create", as: 'city_create'
    get "login", to:"admin#get_login_page", as: 'login'
    get "dashboard", to:"admin#dashboard", as: 'dashboard'
end
scope :admin do
    post "login/auth" , to:"session#admin_login", as: 'admin_login_auth'
end