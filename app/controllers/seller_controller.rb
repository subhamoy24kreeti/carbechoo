class SellerController < ApplicationController
  before_action :seller_authorization, except: [:new, :create]

  def seller_authorization
    if current_user.blank?
      redirect_to root_path and return
    end
    if current_user.role == 'buyer'
      redirect_to buyer_dashboard_path and return
    end
  end

  def new
    render 'signup'
  end

  def create
    @seller = User.new(seller_create_params_check)
    if @seller.save
      session[:user_id] = @seller.id
      SellerMailer.welcome_mail(@seller).deliver
      UserMailer.email_verification_mail(@seller).deliver
      redirect_to root_path, flash: { notice: "Successfully Created! account"}
    else
      redirect_to seller_registration_path, flash: { error: @seller.errors.full_messages}
    end
  end

  def dashboard
    @appointment_under_process = SellerAppointment.recent_processing_appointments(current_user)
    @appointment_under_investigation = SellerAppointment.recent_investigating_appointments(current_user)
    @appointment_approved = SellerAppointment.recent_approved_appointments(current_user)
  end

  def add_car_details
    @states = State.where(country_id: current_user.country_id).map{|st| [st.name, st.id]}
    @cities = City.where(state_id: current_user.city_id).map{|ct| [ct.name, ct.id]}
  end

  def create_seller_appointment
    se = SellerAppointment.new(params_check_seller_appointment_check)
    @user = User.find(params[:seller_appointment][:user_id])
    if se.save
      SellerMailer.appointment_submission_mail(@user, se.id).deliver
      redirect_to seller_add_car_details_path, flash: { notice: "successfully created an appointment"}
    else
      Rails.logger.info(se.errors.full_messages)
      redirect_to seller_add_car_details_path, flash: { error: se.errors.full_messages }
    end
  end

  def seller_appointment_single
    @seller_appointment = SellerAppointment.find_by_id(params[:id])
  end

  def all_appointments
    @all_seller_appointments = SellerAppointment.where(user_id: params[:id])
    render 'all_appointments'
  end

  def seller_create_params_check
    params.require(:seller).permit(:first_name, :last_name, :email, :password, :password_confirmation, :country_id, :state_id, :city_id, :zip_code).merge!(role: 'seller')
  end

  def params_check_seller_appointment_check
    params.require(:seller_appointment).permit(:city_id, :killometer_driven_id, :car_variant_id, :car_model_id, :car_registration_id, :brand_id, :country_id,  :state_id, :city_id, :zip_code, :price, :description, :user_id,
      :year_of_buy, :currency, :car_images => []).merge!(status: 'processing')
  end

end
