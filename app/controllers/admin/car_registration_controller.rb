class Admin::CarRegistrationController < ApplicationController

  before_action :authorize_admin

  def new
    @car_registration = CarRegistration.new
  end

  def create
    p = CarRegistration.new(car_registration_params_check)
    if p.save
      redirect_to new_admin_car_registration_path, :flash => { :notice => "Successfully created" }
    else
      redirect_to new_admin_car_registration_path, :flash => { :error => "an error occured" }
    end
  end

  def edit
    @car_registration = CarRegistration.find(params[:id])
  end

  def update
    @car_registration = CarRegistration.find_by_id(params[:id])
    if @car_registration
      check = @car_registration.update(car_registration_params_check)
      if check
        redirect_to admin_car_registration_index_path, :flash => { :notice => "successfully updated" }
      else
        redirect_to admin_car_registration_index_path, :flash => { :error => "error occured" }
      end
    else
      redirect_to admin_car_registration_index_path, :flash => { :error => "cannot be deleted" }
    end
  end

  def delete
    @car_registration = CarRegistration.find_by_id(params[:id])
    if @car_registration
      @car_registration.destroy
      redirect_to admin_car_registration_index_path, :flash => { :notice => "successfully deleted" }
    else
      redirect_to admin_car_registration_index_path, :flash => { :error => "cannot be deleted" }
    end
  end

  def index
    @car_registrations = CarRegistration.all
  end

  private
  def car_registration_params_check
    params.permit(:state_code)
  end
end
