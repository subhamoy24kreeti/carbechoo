class Admin::BrandController < ApplicationController

  before_action :authorize_admin

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params_check)
    if @brand.save
      redirect_to new_admin_brand_path, flash: { notice: 'Scccessfully created brand' }
    else
      redirect_to new_admin_brand_pathm, flash: { error: 'an error occured' }
    end
  end

  def edit
    @brand = Brand.find_by_id(params[:id])
  end

  def update
    @brand = Brand.find_by_id(params[:id])
    if @brand
      check = @brand.update(brand_params_check)
      if check
        redirect_to admin_brand_index_path, flash: { notice: "successfully updated" }
      else
        redirect_to admin_brand_index_path, flash: { error: "an error occured" }
      end
    else 
      redirect_to admin_brand_index_path, flash: { error: "an error occured" }
    end
  end

  def delete
    p = Brand.find_by_id(params[:id])
    if p
      p.destroy
      redirect_to admin_brand_index_path, flash:{ notice: 'Successfully deleted brand' }
    else
      redirect_to admin_brand_index_path, flash:{ error: 'cannot delete' }
    end
  end

  def index
    @brands = Brand.all
  end

  private
  def brand_params_check
    params.permit(:brand_name)
  end

end
