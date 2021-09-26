class Admin::CountryController < ApplicationController

  before_action :authorize_admin

  def new
    @city = Country.new
  end

  def create
    p = Country.new(name: params[:name])
    if p.save
      redirect_to new_admin_country_path, flash: {notice: "Successfully updated"}
    else
      redirect_to new_admin_country_path, flash: {error: 'an error occured' }
    end
  end

  def edit
    @country = Country.find_by_id(params[:id])
  end

  def update
    check = Country.where(id: params[:id]).update(name: params[:name])
    if check
      redirect_to admin_country_index_path, flash: {notice: 'Successfully updated' }
    else
      redirect_to admin_country_index_path, flash: {error: 'an error occured' }
    end
  end

  def delete
    p = Country.destroy(params[:id])
    if p
      redirect_to admin_country_index_path, flash: {notice: 'Successfully deleted' }
    else
      redirect_to admin_country_index_path, flash: {error: 'an error occured' }
    end
  end

  def index
    @countries = Country.all()
  end
end
