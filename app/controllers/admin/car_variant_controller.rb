class Admin::CarVariantController < ApplicationController

    before_action :authorize_admin
    
    def new
        @car_variant = CarVariant.new
    end
 
    def create
        p = CarVariant.new(variant: params[:variant])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_car_variant_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_car_variant_path
        end
    end
 
    def delete
        p = CarVariant.destroy(params[:id])
        redirect_to admin_car_variant_index_path
    end
 
    def index
        @car_variants = CarVariant.all()
    end

end
