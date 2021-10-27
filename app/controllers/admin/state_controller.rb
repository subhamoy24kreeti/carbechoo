class Admin::StateController < ApplicationController

  before_action :authorize_admin

  def new
    @state = State.new
  end

  def create
    p = State.new(state_params)
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
    @state = State.find_by_id(params[:id])
    if @state
      check = @state.update(state_params)
      if check
        redirect_to admin_state_index_path, flash: { notice: "Successfully updated" }
      else
        redirect_to admin_state_index_path, flash: { notice: "an error occured" }
      end
    else
      redirect_to admin_state_index_path, flash: { error: "Cannot be updated" }
    end
  end

  def delete
    @state = State.find_by_id(params[:id])
    if @state
      @state.destroy
      redirect_to admin_state_index_path, flash: { notice: "Successfully deleted" }
    else
      redirect_to admin_state_index_path, flash: { notice: "cannot be deleted" }
    end
  end

  def index
    @states = State.all
  end

  private

  def state_params
    params.permit(:country_id, :name)
  end
end
