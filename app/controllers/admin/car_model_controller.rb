class Admin::CarModelController < ApplicationController

  before_action :authorize_admin

  def new
  end

  def create
    @car_model = CarModel.new(car_model_params_check)
    if @car_model.save
      redirect_to new_admin_car_model_path, :flash => { :notice => "successfully created" }
    else
      redirect_to new_admin_car_model_path, :flash => { :error => "an error occured" }
    end
  end

  def edit
    @car_model = CarModel.find(params[:id])
  end

  def update
    @car_model = CarModel.find_by_id(params[:id])
    if @car_model
      check = @car_model.update(car_model_params_check)
      if check
        redirect_to admin_car_model_index_path, :flash => { :notice => "Successfully updated" }
      else
        redirect_to admin_car_model_index_path, :flash => { :error => "an error occured" }
      end
    else
      redirect_to admin_car_model_index_path, :flash => { :error => "cannot be deleted" }
    end
  end

  def delete
    @car_model = Brand.find_by_id(params[:id])
    if @car_model
      @car_model.destroy
      redirect_to admin_car_model_index_path, :flash => { :notice => "successfully deleted" }
    else
      redirect_to admin_car_model_index_path, :flash => { :error => "an error occured" }
    end
  end

  def index
    @car_models = CarModel.all
  end

  private
  def car_model_params_check
    params.permit(:brand_id, :name)
  end
end
