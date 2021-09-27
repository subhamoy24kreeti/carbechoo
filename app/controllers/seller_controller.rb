class SellerController < ApplicationController
  before_action :seller_authorization, except: [:new, :create]

  def seller_authorization
    if current_user.blank?
      redirect_to root_path
      return
    end
    if current_user.role == 'buyer'
      redirect_to buyer_dashboard_path
      return
    end
  end

  def new
    @seller = User.new
    @countries = Country.all.map{|country|  [country.name, country.id]}
    render 'signup'
  end


  def create
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

    @seller = User.new(seller)
    @countries = Country.all.map{|country| [country.name, country.id]}
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
    @appointment_under_process = SellerAppointment.limit(5).where(user_id: current_user.id, status: 'processing').order('updated_at DESC')
    @appointment_under_investigation = SellerAppointment.limit(5).where(user_id: current_user.id, status: 'investigating').order('updated_at DESC')
    @appointment_approved = SellerAppointment.limit(5).where(user_id: current_user.id, status: 'approved').order('updated_at DESC')
  end

  def add_car_details
    @cities = City.all.map { |city| [city.name, city.id] }
    @killometer_drivens = KillometerDriven.all.map{|km| [km.killometer_range, km.id]}
    @brands = Brand.all.map{|b| [b.brand_name , b.id]}
    @car_variants = CarVariant.all.map{|v| [v.variant, v.id]}
    @car_models = CarModel.all.map{|c| [c.name, c.id]}
    @car_registrations = CarRegistration.all.map{|cr| [cr.state_code, cr.id]}
    @countries = Country.all.map{|city| [city.name, city.id]}
    @car_registration_year = CarRegistrationYear.first
    @years = []
    for year in @car_registration_year.range1..@car_registration_year.range2
      @years.append([year, year])
    end
    @countries = Country.all.map{|c| [c.name, c.id]}
    @states = State.where(country_id: current_user.country_id).map{|st| [st.name, st.id]}
    @cities = City.where(state_id: current_user.city_id).map{|ct| [ct.name, ct.id]}

  end

  def create_seller_appointment
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

    se = SellerAppointment.new(seller_appointment)
    @user = User.find(params[:user_id])
    if se.save
      SellerMailer.appointment_submission_mail(@user, se.id).deliver
      redirect_to seller_add_car_details_path, flash: { notice: "successfully created an appointment"}
    else
      Rails.logger.info(se.errors.full_messages)
      redirect_to seller_add_car_details_path, flash: {error: se.errors.full_messages}
    end
  end

  def seller_appointment_single
    @seller_appointment = SellerAppointment.find_by_id(params[:id])
  end

  def all_appointments
    @all_seller_appointments = SellerAppointment.where(user_id: params[:id])
    render 'all_appointments'
  end

end
