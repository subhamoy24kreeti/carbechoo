namespace :admin do
  resources :admin
  resources :car_model,  except: [:destroy, :update, :create]
  resources :brand, except: [:destroy, :update, :create]
  resources :car_registration, except: [:destroy, :update, :create]
  resources :car_variant, except: [:destroy, :update, :create]
  resources :country, except: [:destroy, :update, :create]
  resources :state, except: [:destroy, :update, :create]
  resources :city, except: [:destroy, :update, :create]
  resources :car_registration_year, except: [:destroy, :update, :create]
  resources :killometer_driven, except: [:destroy, :update, :create]
  resources :seller_appointment, except: [:destroy, :update, :create]
  resources :buyer_appointment, except: [:destroy, :update, :create]
  resources :cost_range,  except: [:destroy, :update, :create]
  post "brand/create", to:"brand#create", as: 'brand_create'
  post "car-registration-year/create", to:"car_registration_year#create", as: 'car_registration_year_create'
  post "car-registration/create", to:"car_registration#create", as: 'car_registration_create'
  post "car-variant/create", to:"car_variant#create", as: 'car_variant_create'
  post "car-model/create", to:"car_model#create", as: 'car_model_create'
  post "killometer-driven/create", to:"killometer_driven#create", as: 'killometer_driven_create'
  post "country/create", to:"country#create", as: 'country_create'
  post "state/create", to:"state#create", as: 'state_create'
  post "city/create", to:"city#create", as: 'city_create'
  post "cost-range/create", to:"cost_range#create", as: 'cost_range_create'
  get "login", to:"admin#get_login_page", as: 'login'
  get "dashboard", to:"admin#dashboard", as: 'dashboard'

  get 'seller-list', to:'admin#all_seller', as: 'all_seller'
  get 'buyer-list', to: "admin#all_buyer", as: 'all_buyer'
  get 'admin-list', to: 'admin#all_admin', as: 'all_admin'
  get 'car-list', to: 'admin#cars', as: 'all_cars'
  get 'user-view/:id', to: "admin#user_view", as: 'user_view'

  #delete routes
  get 'brand/delete/:id', to: "brand#delete", as:"brand_delete"
  get 'car-model/delete/:id', to: "car_model#delete", as:"car_model_delete"
  get 'car-registration/delete/:id', to: "car_registration#delete", as: "car_registration_delete"
  get 'car-registration-year/delete/:id', to: "car_registration_year#delete", as: "car_registration_year_delete"
  get 'car-variant/delete/:id', to: "car_variant#delete", as: "car_variant_delete"
  get 'city/delete/:id', to: "city#delete", as:"city_delete"
  get 'state/delete/:id', to: "state#delete", as: "state_delete"
  get 'country/delete/:id', to: "country#delete", as: "country_delete"
  get 'cost-range/delete/:id', to: "cost_range#delete", as:"cost_range_delete"
  get 'killometer_driven/delete/:id', to: "killometer_driven#delete", as: "killometer_driven_delete"
  get 'seller-appointment/delete/:id', to: "seller_appointment#delete", as: "seller_appointment_delete"
  get 'buyer-appointment/delete/:id', to: "buyer_appointment#destroy", as: "buyer_appointment_delete"
  get 'user-delete-path/:id', to: "admin#user_destroy", as: 'user_delete';

  #update path
  put 'brand/update/:id', to: "brand#update", as:"brand_update"
  put 'car-model/update/:id', to: "car_model#update", as:"car_model_update"
  put 'car-registration/update/:id', to: "car_registration#update", as: "car_registration_update"
  put 'car-registration-year/update/:id', to: "car_registration_year#update", as: "car_registration_year_update"
  put 'car-variant/update/:id', to: "car_variant#update", as: "car_variant_update"
  put 'city/update/:id', to: "city#update", as:"city_update"
  put 'state/update/:id', to: "state#update", as: "state_update"
  put 'country/update/:id', to: "country#update", as: "country_update"
  put 'cost-range/update/:id', to: "cost_range#update", as:"cost_range_update"
  put 'killometer-driven/update/:id', to: "killometer_driven#update", as: "killometer_driven_update"
  put 'seller-appointment/update/:id', to: "seller_appointment#update", as: "seller_appointment_update"
  put 'buyer-appointment/update/:id', to: "buyer_appointment#update", as: "buyer_appointment_update"
end
scope :admin do
  post "login/auth" , to:"session#admin_login", as: 'admin_login_auth'
end