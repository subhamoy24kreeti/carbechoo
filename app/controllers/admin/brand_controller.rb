class Admin::BrandController < ApplicationController

    before_action :authorize_admin
    
    def new
       @brand = Brand.new
    end

    def create
        @brand = Brand.new(brand_name: params[:brand_name])
        if @brand.save
            flash.now[:alert] = "successfully created brand"
            redirect_to new_admin_brand_path
        else
            flash.now[:alert] = "error occured"
            redirect_to new_admin_brand_path
        end
    end

    def edit
        @brand = Brand.find_by_id(params[:id])
    end

    def update
        Brand.where(id: params[:id]).update(brand_name: params[:brand_name])
        redirect_to admin_brand_index_path
    end

    def delete
        Brand.destroy(params[:id])
        redirect_to admin_brand_index_path
    end

    def index
        @brands = Brand.all()
    end

end
