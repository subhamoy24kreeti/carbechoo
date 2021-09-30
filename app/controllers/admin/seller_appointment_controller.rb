class Admin::SellerAppointmentController < ApplicationController

  before_action :authorize_admin


  def new

  end

  def create
  end


  def edit
    @cities = City.all.map { |city| [city.name, city.id] }
    @killometer_drivens = KillometerDriven.all.map{|km| [km.killometer_range, km.id]}
    @brands = Brand.all.map{|b| [b.brand_name , b.id]}
    @car_variants = CarVariant.all.map{|v| [v.variant, v.id]}
    @car_models = CarModel.all.map{|c| [c.name, c.id]}
    @car_registrations = CarRegistration.all.map{|cr| [cr.state_code, cr.id]}
    @countries = Country.all.map{|city| [city.name, city.id]}
    @states = State.all.map{|s| [s.name, s.id]}
    @car_registration_year = CarRegistrationYear.first()
    @years = []
    for year in @car_registration_year.range1..@car_registration_year.range2
      @years.append([year, year])
    end
    @cost_ranges = CostRange.all.map{|cr| [cr.name, cr.id]}
    @statuses = [['processing',0], ['investigating', 1], ['approved', 2], ['rejecting', 3], ['sold out', 4]]
    @seller_appointment = SellerAppointment.find(params[:id])
  end

  def update
    seller_appointment = helpers.params_check_seller_appointment(params)
    Rails.logger.info(seller_appointment)
    @seller_appointment = SellerAppointment.includes(:user).find(params[:id])
    @seller_appointment.status = params[:status]
    check= @seller_appointment.changed?
    p = @seller_appointment.update(seller_appointment)
    if p
      if check
        SellerMailer.appointment_updates_mail(@seller_appointment).deliver
      end
    end
    redirect_to admin_seller_appointment_index_path
  end

  def index
    @seller_appointments = SellerAppointment.includes(:user, :city).all.order('updated_at DESC')
  end

  def show
    @seller_appointment = SellerAppointment.includes(:user, :city, :state, :country, :brand, :car_model, :killometer_driven, :cost_range, :car_variant, :car_registration).find(params[:id])
    render 'view'
  end

  def delete
    SellerAppointment.destroy(params[:id])
    redirect_to admin_seller_appointment_index_path
  end
end
