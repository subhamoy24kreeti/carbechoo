class Admin::CarVariantController < ApplicationController

  before_action :authorize_admin

  def new
    @car_variant = CarVariant.new
  end

  def create
    p = CarVariant.new(car_variant_params_check)
    if p.save
      redirect_to new_admin_car_variant_path, :flash => { :notice => "Successfully updated" }
    else
      redirect_to new_admin_car_variant_path, :flash => { :error => 'an error occured' }
    end
  end

  def update
    @car_variant = CarVariant.find_by_id(params[:id])
    if @car_variant
      check = @car_variant.update(car_variant_params_check)
      if check
        redirect_to admin_car_variant_index_path, :flash => { :notice => "Successfully updated" }
      else
        redirect_to admin_car_variant_index_path, :flash => { :error => 'an error occured' }
      end
    else
      redirect_to admin_car_variant_index_path, :flash => { :error => 'cannot be deleted' }
    end
  end

  def edit
    @car_variant = CarVariant.find(params[:id])
  end

  def delete
    @car_variant = CarVariant.find_by_id(params[:id])
    if @car_variant
      @car_variant.destroy
      redirect_to admin_car_variant_index_path, :flash => { :notice => "Successfully deleted" }
    else 
      redirect_to admin_car_variant_index_path, :flash => { :error => 'cannot deleted' }
    end
  end

  def index
    @car_variants = CarVariant.all
  end

  private
  def car_variant_params_check
    params.permit(:variant)
  end

end
