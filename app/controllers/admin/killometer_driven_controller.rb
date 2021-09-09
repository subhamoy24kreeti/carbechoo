class Admin::KillometerDrivenController < ApplicationController

    before_action :authorize_admin
    
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

    def edit
        @killometer_driven = KillometerDriven.find_by_id(params[:id])
    end

    def update
        KillometerDriven.where(id: params[:id]).update(killometer_range: params[:killometer_range])
        redirect_to admin_killometer_driven_index_path
    end
 
    def delete
        KillometerDriven.destroy(params[:id])
        redirect_to admin_killometer_driven_index_path
    end
 
    def index
        @killometer_drivens = KillometerDriven.all()
    end
end
