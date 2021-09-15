Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :admin
  draw :api
  
  
  scope :seller do
    get "register", to:"seller#new", as:"seller_registration"
    post "create", to:"seller#create", as:"seller_create"
    get "dashboard", to:"seller#dashboard", as:"seller_dashboard"
    get "add-car-details", to:"seller#add_car_details"
    post "create-seller-appointment", to:'seller#create_seller_appointment', as:'create_seller_appointment'
  end
  

  get 'login', to:"user#login", as:"user_login_get"
  post 'login', to:"session#user_login", as:"user_login_post" 

  #forget password
  get 'forget-password-request', to:'user#forget_password_request', as: 'forget_password_request'
  put 'forget-password-request-generate', to:'user#forget_password_request_generate', as: 'forget_password_request_generate'
  get 'forgrt-password-reset/:password_token', to: "user#forget_password_reset", as: "forget_password_reset"
  put 'forget-password-update/:password_token', to: "user#forget_password_update", as: 'forget_password_update'

  #password update
  get 'get-password-update', to: 'user#get_password_update', as: 'get_password_update'
  put 'password-update', to: 'user#password_update', as: "password_update"
  
  get 'request-for-email-veification', to:'user#email_verification_request_generate', as: "email_verification_request_generate"
  get "verify-email/:id", to:"user#confirm_email", as:"user_email_verification"
  

  get "buyer/register", to:"buyer#new", as:"buyer_registration"
  post "buyer/create", to:"buyer#create", as:"buyer_create"
  get "buyer/dashboard", to:"buyer#dashboard", as:"buyer_dashboard"
  post "buyer/create-appointment", to:"buyer#create_appointment", as: "create_buyer_appointment"
  get "buyer/:id/all-appointments", to:"buyer#all_appointments", as: "all_buyer_appointments"
  get 'buyer/check-status', to: 'buyer#check_status_buyer_appointment', as: 'check_status_buyer_appointment'
  get "car-single/:id", to:"user#car_single", as:"car_single"  
  root "user#landing"



  get 'user-profile/:id', to:"user#user_profile", as:"user_profile"
  put 'user-profile-upadte', to:"user#user_profile_update", as:"user_update_profile"
  get 'nearest-seller', to:"user#nearest_seller", as:'nearest_seller'
  get 'user-settings/:id', to:'user#user_settings', as:'user_settings'

  get "seller/:id/all-appointments", to:"seller#all_appointments", as: "all_seller_appointments"

end
