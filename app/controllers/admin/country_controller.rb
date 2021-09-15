class Admin::CountryController < ApplicationController

    before_action :authorize_admin
    
    def new
        @city = Country.new
    end
 
    def create
        p = Country.new(name: params[:name])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_country_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_country_path
        end
    end

    def edit 
        @country = Country.find_by_id(params[:id])
    end

    def update
        Country.where(id: params[:id]).update(name: params[:name])
        redirect_to admin_country_index_path
    end
 
    def delete
        p = Country.destroy(params[:id])
        redirect_to admin_country_index_path
    end
 
    def index
        @countries = Country.all()
    end
end
