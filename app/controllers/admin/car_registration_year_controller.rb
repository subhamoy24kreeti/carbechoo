class Admin::CarRegistrationYearController < ApplicationController

  before_action :authorize_admin

  def new
    @car_registration_year_range = CarRegistrationYear.new
  end

  def create
    @car_registration_year = CarRegistrationYear.new(car_registration_year_params_check)
    if @car_registration_year.save
      redirect_to admin_car_registration_year_index_path, :flash => { :notice => "Successfully updated" }
    else
      redirect_to new_admin_car_registration_year_path,  :flash => { :notice => "an error occured" }
    end
  end

  def edit
    @car_registration_year = CarRegistrationYear.find(params[:id])
  end

  def update
    @car_registration_year = CarRegistrationYear.find_by_id(params[:id])
    if @car_registration_year
      check = @car_registration_year.update(car_registration_year_params_check)
      if check
        redirect_to admin_car_registration_year_index_path, :flash => { :notice => "Successfully updated" }
      else
        redirect_to admin_car_registration_year_index_path, :flash => { :error => 'an error occured' }
      end
    else
      redirect_to admin_car_registration_year_index_path, :flash => { :error => 'cannot be deleted' }
    end
  end

  def index
    @car_registration_years = CarRegistrationYear.all
  end

  private
  def car_registration_year_params_check
    params.permit(:range1, :range2)
  end

end
