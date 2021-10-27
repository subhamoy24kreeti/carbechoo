class Admin::CountryController < ApplicationController

  before_action :authorize_admin

  def index
    @countries = Country.all
  end

  def new
    @city = Country.new
  end

  def create
    p = Country.new(name: params[:name])
    if p.save
      redirect_to new_admin_country_path, flash: { notice: "Successfully updated"}
    else
      redirect_to new_admin_country_path, flash: { error: 'an error occured' }
    end
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find_by_id(params[:id])
    if @country
      check = @country.update(name: params[:name])
      if check
        redirect_to admin_country_index_path, flash: { notice: 'Successfully updated' }
      else
        redirect_to admin_country_index_path, flash: { error: 'an error occured' }
      end
    else
      redirect_to admin_country_index_path, flash: { error: 'cannot be deleted' }
    end
  end

  def delete
    @country = Country.find_by_id(params[:id])
    if @country
      @country.destroy
      redirect_to admin_country_index_path, flash: { notice: 'Successfully deleted' }
    else
      redirect_to admin_country_index_path, flash: { error: 'cannot be deleted' }
    end
  end
end
