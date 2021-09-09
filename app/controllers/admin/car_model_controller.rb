class Admin::CarModelController < ApplicationController

    before_action :authorize_admin
    
    def new
        @car_model = CarModel.new
        @brands = Brand.all()
    end
 
    def create
        p = CarModel.new(brand_id: params[:brand_id],name: params[:name])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_car_model_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_car_model_path
        end
    end

    def edit 

    end

    def update

    end
 
    def delete
        p = CarModel.destroy(params[:id])
        redirect_to admin_car_model_index_path
    end
 
    def index
        @car_models = CarModel.includes(:brand)
    end
end
