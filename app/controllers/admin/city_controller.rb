class Admin::CityController < ApplicationController
    def new
        @city = City.new
    end
 
    def create
        p = City.new(city: params[:city])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_city_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_city_path
        end
    end
 
    def delete
        p = City.destroy(params[:id])
        redirect_to 'index'
    end
 
    def index
        @cities = City.all()
    end
end
