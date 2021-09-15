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
        Rails.logger.info(seller_appointment)
        @seller_appointment = SellerAppointment.find(params[:id])
        p = @seller_appointment.update(seller_appointment)
        redirect_to admin_seller_appointment_index_path
    end

    def index
        @seller_appointments = SellerAppointment.includes(:user, :city).all
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
