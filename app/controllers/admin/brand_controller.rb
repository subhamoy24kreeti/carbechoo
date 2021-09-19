class Admin::BrandController < ApplicationController

    before_action :authorize_admin
    
    def new
       @brand = Brand.new
    end

    def create
        @brand = Brand.new(brand_name: params[:brand_name])
        if @brand.save
            redirect_to new_admin_brand_path, flash: {notice: 'Scccessfully created brand' }
        else
            redirect_to new_admin_brand_pathm, flash: {error: 'an error occured' }
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
        p = Brand.destroy(params[:id])
        if p
            redirect_to admin_brand_index_path, flash:{notice: 'Successfully deleted brand'}
        else
            redirect_to admin_brand_index_path, flash:{error: 'cannot delete'}
        end

    end

    def index
        @brands = Brand.all()
    end

end
