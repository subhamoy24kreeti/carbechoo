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
        buyer_appointment = BuyerAppointment.new(user_id: params[:user_id], seller_user_id: params[:seller_user_id]);
        if buyer_appointment.save
            render 'appointment_success', info: "Successfully created an appointment"
        else
            render 'user/car_single', error: "Do not create appointment"
        end
    end

    def all_appointments
        @all_buyer_appointments = BuyerAppointment.where(user_id: params[:id])
        render "all_appointments"
    end

    def dashboard
       render 'user/dashboard'
    end

    def index

    end

    def destroy
        User.destroy(params[:id])
    end
end
