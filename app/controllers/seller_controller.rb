class SellerController < ApplicationController

  include SellerHelper
  before_action :seller_authorization, except: [:new, :create]

  def new
    render 'signup'
  end

  def create
    @seller = User.new(seller_create_params_check)
    if @seller.save
      session[:user_id] = @seller.id
      redirect_to root_path, :flash => { :notice => "Successfully Created! account"}
    else
      redirect_to seller_registration_path, :flash => { :error => @seller.errors.full_messages}
    end
  end

  def dashboard
    @appointment_under_process = SellerAppointment.recent_processing_appointments(current_user)
    @appointment_under_investigation = SellerAppointment.recent_investigating_appointments(current_user)
    @appointment_approved = SellerAppointment.recent_approved_appointments(current_user)
  end

  def add_car_details
    @states = State.state_map(current_user.country_id)
    @cities = City.city_map(current_user.state_id)
  end

  def create_seller_appointment
    se = SellerAppointment.new(params_check_seller_appointment_check)
    if se.save
      redirect_to seller_add_car_details_path, :flash => { :notice => "successfully created an appointment"}
    else
      redirect_to seller_add_car_details_path, :flash => { :error => se.errors.full_messages }
    end
  end

  def seller_appointment_single
    @seller_appointment = SellerAppointment.find_by_id(params[:id])
  end

  def all_appointments
    @all_seller_appointments = SellerAppointment.seller_appointment(current_user.id)
  end

  private
  def seller_create_params_check
    params.require(:seller).permit(:first_name, :last_name, :email, :password, :password_confirmation, :country_id, :state_id, :city_id, :zip_code).merge!(role: 'seller')
  end

  def params_check_seller_appointment_check
    params.require(:seller_appointment).permit(:city_id, :killometer_driven_id, :car_variant_id, :car_model_id, :car_registration_id, :brand_id, :country_id,  :state_id, :city_id, :zip_code, :price, :description, :user_id,
      :year_of_buy, :currency, :car_images => []).merge!(:status => 'processing')
  end

end
