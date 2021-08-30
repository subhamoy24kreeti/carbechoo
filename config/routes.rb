Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :admin
  draw :api
  
  get "seller/register", to:"seller#new", as:"seller_registration"
  post "seller/create", to:"seller#create", as:"seller_create"
  get "seller/dashboard", to:"seller#dashboard", as:"seller_dashboard"

  get "buyer/register", to:"buyer#new", as:"buyer_registration"
  post "buyer/create", to:"buyer#create", as:"buyer_create"
  get "buyer/dashboard", to:"buyer#dashboard", as:"buyer_dashboard"
  root "user#landing"

end
