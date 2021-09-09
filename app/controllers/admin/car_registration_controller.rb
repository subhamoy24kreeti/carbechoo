class Admin::CarRegistrationController < ApplicationController

    before_action :authorize_admin
    
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

    def edit 

    end

    def update

    end
 
    def delete
        p = CarRegistration.destroy(params[:id])
        redirect_to admin_car_registration_index_path
    end
 
    def index
        @car_registrations = CarRegistration.all()
    end
end
