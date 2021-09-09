class Admin::CarRegistrationYearController < ApplicationController

  before_action :authorize_admin
  
  def new
    @car_registration_year_range = CarRegistrationYear.new
  end

  def create
    
  end

  def edit 

  end

  def update

  end

  def index
  end
end
