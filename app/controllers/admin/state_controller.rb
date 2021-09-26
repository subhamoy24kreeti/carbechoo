class Admin::StateController < ApplicationController

  before_action :authorize_admin

  def new
    @state = State.new
    @countries = Country.all.map{|country| [country.name, country.id]}
  end

  def create
    p = State.new(country_id: params[:country_id], name: params[:name])
    if p.save
      redirect_to new_admin_state_path, flash: {notice: "Successfully created"}
    else
      redirect_to new_admin_state_path, flash: {error: 'an error occured' }
    end
  end

  def edit
    @countries = Country.all.map{|country| [country.name, country.id]}
    @state = State.find(params[:id])
  end

  def update
    check = State.where(id: params[:id]).update(name: params[:name], country_id: params[:country_id])
    if check
      redirect_to admin_state_index_path, flash: {notice: "Successfully updated"}
    else
      redirect_to admin_state_index_path, flash: {error: "an error occured"}
    end
  end

  def destroy
    State.destroy(params[:id])
    redirect_to admin_state_index_path
  end

  def index
    @states = State.includes(:country).all()
  end
end
