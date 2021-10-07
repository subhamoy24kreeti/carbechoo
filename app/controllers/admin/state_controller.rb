class Admin::StateController < ApplicationController

  before_action :authorize_admin

  def new
    @state = State.new
  end

  def create
    p = State.new(country_id: params[:country_id], name: params[:name])
    if p.save
      redirect_to new_admin_state_path, flash: { notice: "Successfully created" }
    else
      redirect_to new_admin_state_path, flash: { error: 'an error occured' }
    end
  end

  def edit
    @state = State.find_by_id(params[:id])
  end

  def update
    check = State.update_state(params)
    if check
      redirect_to admin_state_index_path, flash: { notice: "Successfully updated" }
    else
      redirect_to admin_state_index_path, flash: { error: "an error occured" }
    end
  end

  def delete
    State.destroy(params[:id])
    redirect_to admin_state_index_path
  end

  def index
    @states = State.all
  end
end
