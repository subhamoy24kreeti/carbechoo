class BuyerController < ApplicationController
    def new
        @buyer = User.new
        render 'signup'
    end

    def create
        buyer = {}
        buyer[:first_name] = params[:first_name]
        buyer[:last_name] = params[:last_name]
        buyer[:email] = params[:email]
        buyer[:password] = params[:password]
        buyer[:password_confirmation] = params[:password_confirmation]
        buyer[:role] = 'buyer'
        if !params[:country_id].blank?
            seller[:country] = Country.find_by_id(params[:country_id]).name
        end

        if !params[:state_id].blank?
            seller[:state] = State.find_by_id(params[:country_id]).name
        end

        if !params[:city_id].blank?
            seller[:city] = City.find_by_id(params[:city_id]).name
        end

        seller[:zip_code] = params[:zip_code]

        @buyer = User.new(buyer)
        
        if @buyer.save
            session[:user_id] = @buyer.id
            flash[:notice] = "Successfully Created! account"
            redirect_to root_path
        else
            session[:user_id] = @buyer.id
            flash[:alert] = "there is something wrong while creating account"
            render 'signup'
        end
    end

    def create_appointment
        if current_user.blank?
            redirect_to 'buyer_login_path'
        end        
        
        buyer_appointment = BuyerAppointment.new(user_id: params[:user_id], seller_user_id: params[:seller_user_id]);
        if buyer_appointment.save
            render 'appointment_success', info: "Successfully created an appointment"
        else
            render 'user/car_single', error: "Do not create appointment"
        end
    end

    def check_status_buyer_appointment
        appointment_id = params[:appointment_id]
        appointment = BuyerAppointment.find(appointment_id);
        if !appointment.blank?
            render json: {status: 1, error: 0, msg: appointment[0].status}
        else
            render json: {status: 0, error: 1, msg: 'not found'}
        end
    rescue
        render json: {status: 0, error: 1, msg: 'not found'}
    end

    def all_appointments
        @all_buyer_appointments = BuyerAppointment.where(user_id: params[:id])
        render "all_appointments"
    end

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

        render 'user/dashboard'
    end

    def index

    end

    def destroy
        User.destroy(params[:id])
    end
end
