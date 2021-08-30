class Admin::KillometerDrivenController < ApplicationController
    def new
        @killometer_driven = KillometerDriven.new
    end
 
    def create
        p = KillometerDriven.new(killometer_range: params[:killometer_range])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_killometer_driven_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_killometer_driven_path
        end
    end
 
    def delete
        p = KillometerDriven.destroy(params[:id])
        redirect_to 'index'
    end
 
    def index
        @killometer_drivens = KillometerDriven.all()
    end
end
