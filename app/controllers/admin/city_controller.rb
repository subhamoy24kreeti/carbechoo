class Admin::CityController < ApplicationController

  before_action :authorize_admin

  def new
  end

  def create
    p = City.new(city_params_check)
    if p.save
      redirect_to new_admin_city_path, flash: { notice: "Successfully updated" }
    else
      redirect_to new_admin_city_path, flash: { notice: "cannot be created" }
    end
  end

  def edit
    @city = City.find(params[:id])
    @state = State.find(@city.state_id)
  end

  def update
    @city = City.find_by_id(params[:id])
    if @city
      check = @city.update(city_params_check)
      if check
        redirect_to admin_city_index_path, flash: { notice: "Successfully updated" }
      else 
        redirect_to admin_city_index_path, flash: { error: 'an error occured' }
      end
    else
      redirect_to admin_city_index_path, flash: { error: 'cannot be deleted' }
    end
  end

  def delete
    @city = City.find_by_id(params[:id])
    if @city
      @city.destroy
      redirect_to admin_city_index_path, flash: { notice: "Successfully deleted"}
    else
      redirect_to admin_city_index_path, flash: { error: 'cannot be deleted' }
    end
  end

  def index
    @cities = City.all()
  end

  private

  def city_params_check
    params.permit(:state_id, :name)
  end  
end
