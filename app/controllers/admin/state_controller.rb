class Admin::StateController < ApplicationController

    before_action :authorize_admin
    
    def new
        @state = State.new
        @countries = Country.all.map{|country| [country.name, country.id]}
    end
 
    def create
        p = State.new(country_id: params[:country_id], name: params[:name])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_state_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_state_path
        end
    end

    def edit 

    end

    def update

    end
 
    def destroy
        State.destroy(params[:id])
        redirect_to admin_state_index_path
    end
 
    def index
        @states = State.includes(:country).all()
    end
end
