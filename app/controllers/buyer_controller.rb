class BuyerController < ApplicationController

  before_action :buyer_authorization, except: [:new, :create]

  def buyer_authorization
    if current_user.blank?
    redirect_to root_path
    return
    end
    if current_user.role == 'seller'
    redirect_to seller_dashboard_path
    return
    end
  end

  def new
    @buyer = User.new
    @countries = Country.all.map{|c| [c.name, c.id]}
    render 'signup'
  end

  #buyer sign up controller
  def create
    buyer = {}
    buyer[:first_name] = params[:first_name]
    buyer[:last_name] = params[:last_name]
    buyer[:email] = params[:email]
    buyer[:password] = params[:password]
    buyer[:password_confirmation] = params[:password_confirmation]
    buyer[:role] = 'buyer'
    buyer[:country_id] = params[:country_id]
    buyer[:state_id] = params[:state_id]
    buyer[:city_id] = params[:city_id]

    buyer[:zip_code] = params[:zip_code]

    @buyer = User.new(buyer)
    @countries = Country.all.map{|country| [country.name, country.id]}
    if @buyer.save
    session[:user_id] = @buyer.id
    BuyerMailer.welcome_mail(@buyer).deliver
    UserMailer.email_verification_mail(@buyer).deliver
    redirect_to buyer_dashboard_path, flash: {notice: "Successfully Created! account" }
    else
    redirect_to buyer_registration_path, flash: {error: @buyer.errors.full_messages }
    end
  end

  #buyer appointment creation controller
  def create_appointment
    if current_user.blank?
    redirect_to 'buyer_login_path'
    return
    end
    buyer_appointment = BuyerAppointment.new(user_id: current_user.id, seller_appointment_id: params[:seller_appointment_id]);
    if buyer_appointment.save
    BuyerMailer.appointment_submission_mail(current_user, buyer_appointment.id).deliver
    render 'appointment_success', info: "Successfully created an appointment"
    else
    redirect_to car_single_path(params[:seller_appointment_id]), error: "Do not create appointment"
    end
  end

  #buyer show my appointments
  def all_appointments
    @all_buyer_appointments = BuyerAppointment.where(user_id: params[:id])
    render "all_appointments"
  end

  #buyer dashboard
  def dashboard
    @cities = City.all.map{|city| [city.name, city.id]}
    @brands = Brand.all.map{|brand| [brand.brand_name, brand.id]}
    @car_models = CarModel.all.map{|car_model| [car_model.name, car_model.id]}
    @car_variants = CarVariant.all.map{|car_variant| [car_variant.variant, car_variant.id]}
    @car_registrations = CarRegistration.all.map{|car_registration| [car_registration.state_code, car_registration.id]}
    @killometer_drivens = KillometerDriven.all.map{|killometer_driven| [killometer_driven.killometer_range, killometer_driven.id]}
    @cost_ranges = CostRange.all.map{|cost_range| [cost_range.currency+cost_range.range1.to_s+"-"+cost_range.range2.to_s, cost_range.id]}
    @car_registration_year = CarRegistrationYear.first()
    @years = []
    for year in @car_registration_year.range1..@car_registration_year.range2
    @years.append([year, year])
    end
    @cars = SellerAppointment.where(status: 'approved')
  end

end
