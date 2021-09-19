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
            redirect_to new_admin_city_path, flash: {notice: "Successfully updated"}
        else
            redirect_to new_admin_city_path
        end
    end

    def edit 
        @city = City.find(params[:id])
        state = State.find(@city.state_id)
        @countries = Country.all.map{|country| [country.name, country.id]}
        @selected_country_id = state.country_id
        @states = State.where('country_id=?', state.country_id).map{|country| [country.name, country.id]}
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
