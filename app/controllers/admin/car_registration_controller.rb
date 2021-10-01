class Admin::CarRegistrationController < ApplicationController

  before_action :authorize_admin

  def new
    @car_registration = CarRegistration.new
  end

  def create
    p = CarRegistration.new(state_code: params[:state_code])
    if p.save
      redirect_to new_admin_car_registration_path, flash: {notice: "Successfully created"}
    else
      redirect_to new_admin_car_registration_path, flash: {error: "an error occured"}
    end
  end

  def edit
    @car_registration = CarRegistration.find(params[:id])
  end

  def update
    check = CarRegistration.update_car_registration(params)
    if check
      redirect_to admin_car_registration_index_path, flash: {notice: "successfully updated"}
    else
      redirect_to admin_car_registration_index_path, flash: {error: "error occured"}
    end
  end

  def delete
    p = CarRegistration.destroy(params[:id])
    if p
      redirect_to admin_car_registration_index_path, flash: {notice: "successfully deleted"}
    else
      redirect_to admin_car_registration_index_path, flash: {error: "error occured"}
    end
  end

  def index
    @car_registrations = CarRegistration.all
  end
end
