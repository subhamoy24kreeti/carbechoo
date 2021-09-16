class UserController < ApplicationController

    before_action :user_authorization, only: [:user_settings, :user_profile_update ]

    def landing
        @cities = City.all.map{|city| [city.name, city.id]}
        @brands = Brand.all.map{|brand| [brand.brand_name, brand.id]}
        @car_models = CarModel.all.map{|car_model| [car_model.name, car_model.id]}
        @car_variants = CarVariant.all.map{|car_variant| [car_variant.variant, car_variant.id]}
        @car_registrations = CarRegistration.all.map{|car_registration| [car_registration.state_code, car_registration.id]}
        @killometer_drivens = KillometerDriven.all.map{|killometer_driven| [killometer_driven.killometer_range, killometer_driven.id]}
        @cost_ranges = CostRange.all.map{|cost_range| [cost_range.currency+cost_range.range1.to_s+"-"+cost_range.range2.to_s, cost_range.id]}
        @cars = SellerAppointment.where(status: 'approved') 
        @car_registration_year = CarRegistrationYear.first()
        @years = []
        for year in @car_registration_year.range1..@car_registration_year.range2
            @years.append([year, year])
        end
        render 'landing'
    end

    def car_single
        @car = SellerAppointment.find(params[:id]);
        render 'car_single'
    end

    def forget_password_request
        render 'forget_password_request'
    end

    def forget_password_request_generate
        email = params[:email]
        @user_data = User.find_by_email(email)
        if !@user_data.blank?
            @user_data.password_reset_token_make = true
            if @user_data.save
                UserMailer.forget_password_change_mail(@user_data).deliver
                @response = "Successfully link sent to your mail"
                render 'forget_password_response'
            
            else
                redirect_back(fallback_location: {action: 'forget_password_request'}, flash: { notice: "Successfully Created! account"})
            end
        else
            redirect_back(fallback_location: {action: 'forget_password_request'})
        end
    end

    def forget_password_reset
        @user = User.find_by_password_reset_token(params[:password_token])
        time_now = Time.now
        time_diff = (@user.password_reset_token_sent_at - time_now)/60
        if @user.blank?
            @response = "Invalid Authentication"
            render 'forget_password_response'
            return
        end
        if time_diff > 20
            @response = "Your link is expired"
            render 'forget_password_response'
            return
        end
        render 'forget_password_reset'
        return
    end

    def forget_password_update
        params[:id]
        params[:password_token]
        params[:password_confirmation]
        params[:password]
        @user = User.find(params[:id])
        if !@user.password_reset_token.blank? && @user.password_reset_token == params[:password_token]
            @user.updating_password = true
            check = @user.update(password: params[:password], password_confirmation: params[:password_confirmation], password_reset_token: null, password_reset_token_sent_at: null)           
            if check 
                @response = "Successfully updated your password please login now"
                render 'forget_password_response'
            else
                @response = "There is a problem while updating your password"
                render 'forget_password_response'
            end
        else
            @response = "Invalid authentication|404"
            render 'forget_password_response'
        end
    end

    def password_update

    end

    def email_verification_request_generate
        @user = User.find(params[:user_id])
        if !@user.blank? 
            @user.email_verification_token_make = true
            if @user.save
                UserMailer.email_verification_mail(@user).deliver_now
                render json: {status: 1, error: 0, msg: 'successfully sent mail' }
            else
                render json: {status: 0, error: 1, msg: 'sorry there is a problem'}
            end
        else
            render json: {status: 0, error: 1, msg: 'sorry there is sa problem'}
        end
    end

    def confirm_email
        @user = User.find_by_confirm_token_email(params[:id])
        if @user
            @user.activate_email
            redirect_to root_path, flash: { notice: "Successfully verified email"} 
        else
            redirect_to root_path, flash: { alert: "Some thing went wrong"}
        end
    end

    def verify_email
        user = User.find(params[:user_id])
        if user.email_confirmed
            render json: {status: 1, error: 0, msg: 'email verified'}
        else
            render json: {status: 0, error:1, msg: 'email not verified'}
        end
    rescue
        render json: {status: 0, error: 1, msg: 'not found'}
    end


    def ws_get_cities
        @cities = City.where(state_id: params[:state_id])
        option = "<option value=''>--select your city--</option>"
        @cities.each do |city|
            option = option + "<option value=#{city.id}>#{city.name}</option>"
        end
        render json: {html: option}
    end
    
    skip_before_action :verify_authenticity_token
    def ws_user_cover_pic_upload
        image = params[:cover_pic]
        @user = User.find(params[:id])
        @user.cover_pic.attach(params[:cover_pic])
        Rails.logger.info(@user.errors.full_messages)
        render json: {image: url_for(@user.cover_pic)}
    end
    
    skip_before_action :verify_authenticity_token, raise: false
    def ws_user_profile_pic_upload
        image = params[:profile_pic]
        @user = User.find(params[:id])
        @user.profile_pic.attach image
        render json: {image: url_for(@user.profile_pic)}
    end

    def user_profile
        @seller = User.find(params[:id])
        @latest_seller_items = SellerAppointment.limit(5).where(user_id: params[:id], status: 'approved').order('updated_at DESC')
        render 'user_profile'
    end

    def nearest_seller
        @sellers = User.where(role: 'seller')
        render 'buyer/nearest_sellers'
    end

    def user_settings
        @user = User.find(params[:id])

        if @user.country
            @user_country_id = Country.find_by_name(@user.country).id
            @countries = Country.all
        end

        if @user.state
            @user_state_id = State.find_by_name(@user.state).id
            @states = State.where(country_id: @user_country_id)
        end

        if @user.city
            @user_city_id = City.find_by_name(@user.city).id  
            @cities = City.where(state_id: @user_state_id)     
        end

        @countries =  Country.all.map{|country| [country.name, country.id]}
        @states =  State.all.map{|state| [state.name, state.id]}
        @cities =  City.all.map{|city| [city.name, city.id]}

        render 'user/user_settings'
    end

    def user_profile_update
        update_user = {}
        update_user[:first_name] = params[:first_name]
        update_user[:last_name] = params[:last_name]
        update_user[:country] = Country.find(params[:country_id]).name
        update_user[:state] = State.find(params[:state_id]).name
        update_user[:city] = City.find(params[:city_id]).name
        update_user[:phone] = params[:phone]
        update_user[:zip_code] = params[:zip_code]
        user =  User.find(params[:id])
         
        email_changed = false
        if user.email != params[:email]
            user.email = params[:email]
            if user.changed?
                email_changed = true
                update_user[:email] = params[:email]
                update_user[:updating_email] = true
            end
        end

        if !params[:phone].blank? && !user.phone.blank?
            if(params[:phone] != user.phone.blank)
                update_user[:phone] = params[:phone]
            end
        end
        
        p = user.update(update_user)
        
        if p
            if(email_changed)
                Rails.logger.info(user.email)
                UserMailer.email_verification_mail(user).deliver
            end
            if user.role == 'seller'
                redirect_to seller_dashboard_path, flash: { notice: "Successfully Created! account"}
            else
                redirect_to buyer_dashboard_path, flash: { notice: "Successfully Created! account"}
            end
        else
            session[:user_id] = user.id
            redirect_to user_settings_path(params[:id]), flash: { alert: "there is something wrong while creating account"}
        end
    end

    def ws_get_states
        @states = State.where(country_id: params[:country_id])
        options = "<option value=''>--select your state--</option>"
        @states.each do |state|
            options = options+ "<option value=#{state.id}>#{state.name}</option>"
        end
        render json: {html: options}
    end

    def ws_get_car_models
        @car_models = CarModel.where(brand_id: params[:brand_id])
        options = ""
        @car_models.each do |car_model|
            options = options + "<option value=#{car_model.id}>#{car_model.name}</option>"
        end
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
            render json: {status: 1, error: 0, msg: appointment.status}
        else
            render json: {status: 0, error: 1, msg: 'not found'}
        end
    rescue
        render json: {status: 0, error: 1, msg: 'not found'}
    end

    def get_filtered_cars
        query = ""
        params_for_filter = {}
        page = 0
        if( !params[:page].blank? == 0)
            page = params[:page]
        end

        cars = SellerAppointment.offset(page*10).limit(10).where(status: 'approved')

        if !params[:city_id].blank?
            cars = cars.where(city_id: params[:city_id])
        end

        if !params[:brand_id].blank?

            cars = cars.where(brand_id: params[:brand_id])
        end

        if !params[:car_model_id].blank?
            cars = cars.where(car_model_id: params[:car_model_id])
        end

        if !params[:year_of_buy].blank?
            cars = cars.where(year_of_buy: params[:year_of_buy])
        end

        if !params[:car_variant_id].blank?
            cars = cars.where(car_variant_id: params[:car_variant_id])
        end

        if !params[:car_registration_id].blank?
            cars = cars.where(car_registration_id: params[:car_registration_id])
        end

        if !params[:killometer_driven_id].blank?
            cars = cars.where(killometer_driven_id: params[:killometer_driven_id])
        end

        if !params[:cost_range_id].blank?
            cars = cars.where(cost_range_id: params[:cost_range_id])
        end

        if !params[:search].blank?
            cars = cars.search_filter(params[:search])
        end

        cars.order('updated_at DESC')
    
        cars = cars.map{|car| {:description => car.description, :price => car.price, :image_url => url_for(car.car_images[0]), :single_link => car_single_path(car.id) }}
        
        render json: { cars: cars }
    end

    
    def login
        render 'login'
    end

end
