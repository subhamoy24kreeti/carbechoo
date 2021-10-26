module Admin::SellerAppointmentHelper

  def params_check_seller_appointment(params)
    statuses = ['processing', 'investigating', 'approved', 'rejecting', 'sold out']
    if !params[:status].blank?
      params[:status] = statuses[params[:status].to_i]
    end

    seller_appointment = {}
    seller_appointment[:brand_id] = params[:brand_id]
    seller_appointment[:car_model_id] = params[:car_model_id]
    seller_appointment[:killometer_driven_id] = params[:killometer_driven_id]
    seller_appointment[:car_registration_id] = params[:car_registration_id]
    seller_appointment[:car_variant_id] = params[:car_variant_id]
    seller_appointment[:description] = params[:description]
    seller_appointment[:price] = params[:price]
    seller_appointment[:country_id] = params[:country_id]
    seller_appointment[:state_id] = params[:state_id]
    seller_appointment[:city_id] = params[:city_id]
    seller_appointment[:status] = params[:status]
    seller_appointment[:scheduled_date] = params[:scheduled_date]
    seller_appointment[:scheduled_time] = params[:scheduled_time]
    seller_appointment[:year_of_buy] = params[:year_of_buy]

    if !params[:cost_range_id].blank?
      seller_appointment[:cost_range_id] = params[:cost_range_id];
    end
    seller_appointment
  end
end
