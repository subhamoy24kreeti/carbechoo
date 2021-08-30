class Admin::BrandController < ApplicationController
    def new
       @brand = Brand.new
    end

    def create
        p = Brand.new(brand_name: params[:brand_name])
        if p.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_brand_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_brand_path
        end
    end

    def delete
        p = Brand.destroy(params[:id])
        redirect_to 'index'
    end

    def index
        @brands = Brand.all()
    end

end
