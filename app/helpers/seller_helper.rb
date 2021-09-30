module SellerHelper

  def seller_user_params_check(params)
    Rails.logger.info(params)
    seller = {}
    seller[:first_name] = params[:first_name]
    seller[:last_name] = params[:last_name]
    seller[:email] = params[:email]
    seller[:password] = params[:password]
    seller[:password_confirmation] = params[:password_confirmation]
    seller[:role] = "seller"
    seller[:country_id] = params[:country_id]
    seller[:state_id] = params[:state_id]
    seller[:city_id] = params[:city_id]

    seller[:zip_code] = params[:zip_code]
    seller
  end

  def seller_appointment_create(params)
    seller_appointment = {}
    seller_appointment[:city_id] = params[:city_id]
    seller_appointment[:killometer_driven_id] = params[:killometer_driven_id]
    seller_appointment[:car_variant_id] = params[:car_variant_id]
    seller_appointment[:car_model_id] = params[:car_model_id]
    seller_appointment[:car_registration_id] = params[:car_registration_id]
    seller_appointment[:brand_id] = params[:brand_id]
    seller_appointment[:country_id] = params[:country_id]
    seller_appointment[:state_id] = params[:state_id]
    seller_appointment[:city_id] = params[:city_id]
    seller_appointment[:zip_code] = params[:zip_code]
    seller_appointment[:status] = 'processing'
    seller_appointment[:price] = params[:price]
    seller_appointment[:description] = params[:description]
    seller_appointment[:car_images] = params[:car_images]
    seller_appointment[:user_id] = params[:user_id]
    seller_appointment[:year_of_buy] = params[:year_of_buy]
    seller_appointment[:currency] = params[:currency]
    seller_appointment
  end
end
