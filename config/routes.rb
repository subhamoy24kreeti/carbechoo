Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :admin
  draw :api
  
  
  scope :seller do
    get "verify-email/:id", to:"seller#confirm_email", as:"seller_email_verification"
    get "register", to:"seller#new", as:"seller_registration"
    post "create", to:"seller#create", as:"seller_create"
    get "dashboard", to:"seller#dashboard", as:"seller_dashboard"
    get "add-car-details", to:"seller#add_car_details"
    post "create-seller-appointment", to:'seller#create_seller_appointment', as:'create_seller_appointment'
  end
  
  get 'login', to:"user#login", as:"user_login_get"
  post 'login', to:"session#user_login", as:"user_login_post" 
  get "buyer/register", to:"buyer#new", as:"buyer_registration"
  post "buyer/create", to:"buyer#create", as:"buyer_create"
  get "buyer/dashboard", to:"buyer#dashboard", as:"buyer_dashboard"
  post "buyer/create-appointment", to:"buyer#create_appointment", as: "create_buyer_appointment"
  get "buyer/:id/all-appointments", to:"buyer#all_appointments", as: "all_buyer_appointments"
  get "car-single/:id", to:"user#car_single", as:"car_single"  
  root "user#landing"

end
