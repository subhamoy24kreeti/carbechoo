class Admin::CarRegistrationYearController < ApplicationController

  before_action :authorize_admin
  
  def new
    @car_registration_year_range = CarRegistrationYear.new
  end

  def create
    car_registration_year = {}
    car_registration_year[:range1] = params[:range1]
    car_registration_year[:range2] = params[:range2]
    @car_registration_year = CarRegistrationYear.new(car_registration_year)
    if @car_registration_year.save
        redirect_to admin_car_registration_year_index_path
    else
        redirect_to new_admin_car_registration_year_path
    end
  end

  def edit 
    @car_registration_year = CarRegistrationYear.find(params[:id])
  end

  def update

  end

  def index
    @car_registration_years = CarRegistrationYear.all 
  end
end
