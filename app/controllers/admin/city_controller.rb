class Admin::CityController < ApplicationController

    before_action :authorize_admin
    
    def new
        @city = City.new
        @states = State.all.map{|state| [state.name, state.id] }
        @countries = Country.all.map{|country| [country.name, country.id]}        
    end
 
    def create
        p = City.new(state_id:params[:state_id], name: params[:name])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_city_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_city_path
        end
    end

    def edit 

    end

    def update

    end
 
    def delete
        p = City.destroy(params[:id])
        redirect_to admin_city_index_path
    end
 
    def index
        @cities = City.includes(:state, :country).all()
    end
end
