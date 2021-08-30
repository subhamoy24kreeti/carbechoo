class Admin::CarModelController < ApplicationController
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
 
    def delete
        p = CarModel.destroy(params[:id])
        redirect_to 'index'
    end
 
    def index
        @car_models = CarModel.includes(:brand)

    end
end
