class Admin::CarRegistrationController < ApplicationController
    def new
        @car_registration = CarRegistration.new
    end
 
    def create
        p = CarRegistration.new(state_code: params[:state_code])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_car_registration_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_car_registration_path
        end
    end
 
    def delete
        p = CarRegistration.destroy(params[:id])
        redirect_to 'index'
    end
 
    def index
        @car_registrations = CarRegistration.all()
    end
end
