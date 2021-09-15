class SellerController < ApplicationController

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
        if !params[:country_id].blank?
            seller[:country] = Country.find_by_id(params[:country_id]).name
        end

        if !params[:state_id].blank?
            seller[:state] = State.find_by_id(params[:state_id]).name
        end

        if !params[:city_id].blank?
            seller[:city] = City.find_by_id(params[:city_id]).name
        end

        seller[:zip_code] = params[:zip_code]

        @seller = User.new(seller)
        if @seller.save
            session[:user_id] = @seller.id
            SellerMailer.welcome_mail(@seller).deliver_now
            verify_link = seller_email_verification_url(@seller.confirm_token_email)
            SellerMailer.email_verification_mail(@seller, verify_link).deliver
            redirect_to root_path, flash: { notice: "Successfully Created! account"}
        else
            session[:user_id] = @seller.id
            render "signup", flash: { alert: "there is something wrong while creating account"}
        end
    end

    def dashboard
        @cars = SellerAppointment.where(status: 'approved')
        render 'user/dashboard'
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
        render 'add_car_details'
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
        
        se = SellerAppointment.new(seller_appointment)
        @user = User.find(params[:user_id])
        if se.save
            SellerMailer.appointment_submission_mail(@user, se.id)
            redirect_to add_car_details_path, notice: "successfully created an appointment"
        else
            Rails.logger.info(se.errors.full_messages)
            redirect_to add_car_details_path, notice: "there is some error while creating appointment"
        end
    end

    def all_appointments
        @all_seller_appointments = SellerAppointment.all
        render 'all_appointments'
    end
    
    def index

    end

    def destroy

    end

end
