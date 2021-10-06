class Admin::CityController < ApplicationController

  before_action :authorize_admin

  def new
  end

  def create
    p = City.new(state_id:params[:state_id], name: params[:name])
    if p.save
      redirect_to new_admin_city_path, flash: {notice: "Successfully updated"}
    else
      redirect_to new_admin_city_path
    end
  end

  def edit
    @city = City.find(params[:id])
    @state = State.find(@city.state_id)
  end

  def update
    check = City.update_city(params)
    if check
      redirect_to admin_city_index_path, flash: {notice: "Successfully updated"}
    else
      redirect_to admin_city_index_path, flash: {error: 'an error occured' }
    end
  end

  def delete
    p = City.destroy(params[:id])
    redirect_to admin_city_index_path
  end

  def index
    @cities = City.all()
  end
end
