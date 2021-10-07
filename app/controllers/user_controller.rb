class UserController < ApplicationController

  include ApplicationHelper
  include UserHelper

  before_action :authorize_user, only: [:user_settings, :user_profile_update]
  skip_before_action :verify_authenticity_token, only: [:ws_user_profile_pic_upload, :ws_user_cover_pic_upload]

  def landing
    if !current_user.blank?
      if current_user.is_seller?
        redirect_to seller_dashboard_path and return
      else
        redirect_to buyer_dashboard_path and return
      end
    end
  end

  def car_single
    @car = SellerAppointment.find(params[:id])
  end

  def forget_password_request
  end

  def forget_password_request_generate
    email = params[:email]
    @user_data = User.find_by_email(email)
    if !@user_data.blank?
      if @user_data.forget_password_key_set
        @response = "Successfully link sent to your mail"
        render 'forget_password_response', flash: { notice: "Successfully sent link" }
      else
        redirect_back(fallback_location: { action: :forget_password_request }, flash: { notice: "there is something went wrong" })
      end
    else
      redirect_back(fallback_location: { action: :forget_password_request })
    end
  end

  def save_user_phone

    if params[:user_id].blank?
      render json: { status: 0, error: 1, msg:"error occured" }
    end

    if params[:phone].blank?
      render json: { status: 0, error: 1, msg:"error occured" }
    end

    @user = User.find(params[:user_id])
    @user.phone = params[:phone]
    if @user.save
      render json: { status: 1, error: 0, msg: "phone number updated" }
    else
      render json: { status: 0, error: 1, msg:"error occured" }
    end
  rescue
    render json: { status: 0, error: 1, msg:"error occured" }
  end

  def forget_password_reset
    @user = User.find_by_password_reset_token(params[:password_token])
    time_now = Time.now
    if @user.blank? || @user.password_reset_token_sent_at.blank?
      @response = "Invalid Authentication"
      render 'forget_password_response' and return
    end
    time_diff = (@user.password_reset_token_sent_at - time_now)/60
    if @user.blank?
      @response = "Invalid Authentication"
      render 'forget_password_response' and return
    end
    if time_diff > 20
      @response = "Your link is expired"
      render 'forget_password_response' and return
    end
    render 'forget_password_reset'
  end

  def forget_password_update
    @user = User.find(params[:id])
    if @user.blank?
      render user_login_get and return
    end
    if !@user.password_reset_token.blank? && @user.password_reset_token == params[:password_token]
      @user.updating_password = true
      check = @user.update_forget_password(params)
      if check
        @response = "Successfully updated your password please login now"
        @success = 1
        render 'forget_password_response'
      else
        @response = "There is a problem while updating your password"
        render 'forget_password_response'
      end
    else
      render user_login_get
    end
  rescue
    render user_login_get
  end

  def get_password_update
    render 'user_password_change'
  end

  def password_update
    @user = User.find_by_id(current_user.id)
    if @user.authenticate(params[:old_password])
      @user.updating_password = true
      check = @user.update_password(params)
      if check
        redirect_to user_settings_path, flash: { notice: "Successfully updated password" }
      else
        redirect_to get_password_update_path, flash: { error: @user.errors.full_messages }
      end
    else
      redirect_to get_password_update_path, flash: { error: ['password does not match'] }
    end
  end

  def email_verification_request_generate
    @user = User.find(params[:user_id])
    if !@user.blank?
      check = @user.email_verification_key_set
      if check
        render json: { status: 1, error: 0, msg: 'successfully sent mail' }
      else
        render json: { status: 0, error: 1, msg: 'sorry there is a problem' }
      end
    else
      render json: { status: 0, error: 1, msg: 'sorry there is sa problem' }
    end
  rescue
    render json: { status: 0, error: 1, msg: 'sorry there is sa problem' }
  end

  def confirm_email
    @user = User.find_by_confirm_token_email(params[:id])
    if @user
      @user.activate_email
      redirect_to root_path, flash: { notice: "Successfully verified email" }
    else
      redirect_to root_path, flash: { error: "Some thing went wrong" }
    end
  end

  def verify_email
    user = User.find(params[:user_id])
    if user.email_confirmed
      render json: { status: 1, error: 0, msg: 'email verified' }
    else
      render json: { status: 0, error:1, msg: 'email not verified' }
    end
  rescue
    render json: { status: 0, error: 1, msg: 'not found' }
  end


  def ws_get_cities
    cities = State.get_cities(params[:state_id])
    option = get_city_options(cities)
    render json: { html: option }
  end

  def ws_user_cover_pic_upload
    image = params[:cover_pic]
    @user = User.find_by_id(params[:id])
    if(@user.blank?)
      render json: { status: 0, error: 1 } and return
    end
    ch = @user.cover_pic.attach(params[:cover_pic])
    if ch
      render json: { image: url_for(@user.cover_pic), error: 0, status:1 }
    else
      render json: { status: 0, error: 1 }
    end
  rescue
    render json: { status: 0, error: 1 }
  end

  def ws_user_profile_pic_upload
    image = params[:profile_pic]
    @user = User.find_by_id(params[:id])
    if @user.blank?
      render json: { status: 0, error: 1 }
    end

    ch = @user.profile_pic.attach image

    if ch
      render json: { image: url_for(@user.profile_pic), status: 1, error: 0, ch: ch }
    else
      render json: { status: 0, error: 1, ch: ch }
    end
  rescue
    render json: { status: 0, error: 1, ch: ch }
  end

  def user_profile
    @seller = User.find(params[:id])
    @latest_seller_items = SellerAppointment.latest_seller_cars(params)
  end

  def sellers
    @sellers = User.seller_with_offset(0)
    render 'buyer/sellers'
  end

  def ws_get_seller_profiles
    page = 0
    if !params[:page].blank?
      page = params[:page].to_i
    end
    offset = page*10
    sellers = User.seller_with_offset(offset)
    sellers = seller_formated(sellers)
    render json: {sellers: sellers}
  end

  def user_settings
    @states = State.state_map(current_user.country_id)
    @cities = City.city_map(current_user.state_id)
  end

  def user_profile_update
    user =  User.find(params[:id])
    update_user = update_user_profile_params_check(params)
    email_changed = false
    check = user.user_profile_update(update_user)

    if check
      redirect_to user_settings_path, flash: { notice: "Successfully updated! account" }
    else
      redirect_to user_settings_path, flash: { error: user.errors.full_messages }
    end

  end

  def ws_get_states
    states = Country.get_states(params)
    options = get_state_options(states)
    render json: {html: options}
  end

  def ws_get_car_models
    car_models = CarModel.get_car_models_by_brand(params)
    options = get_car_model_options(car_models)
    render json: {html: options}
  end

  def check_status_appointment
    appointment_id = params[:appointment_id]
    role = params[:role]
    if role == 'buyer'
      appointment = BuyerAppointment.find(appointment_id);
    else
      appointment = SellerAppointment.find(appointment_id);
    end
    if !appointment.blank?
      render json: { status: 1, error: 0, msg: appointment.status }
    else
      render json: { status: 0, error: 1, msg: 'not found' }
    end
  rescue
    render json: { status: 0, error: 1, msg: 'not found' }
  end

  def get_filtered_cars
    cars = SellerAppointment.params_filter(params)
    cars = car_formated(cars)
    render json: { cars: cars }
  end

  def login
  end

end
