class Admin::CostRangeController < ApplicationController

  before_action :authorize_admin

  def new
    @cost_range = CostRange.new
  end

  def create
    @cost_range = CostRange.new(check_cost_range_params)
    if(@cost_range.save)
      redirect_to new_admin_cost_range_path, :flash => { :notice =>  "Successfully created"}
    else
      redirect_to new_admin_cost_range_path, :flash => { :error => 'an error occured' }
    end
  end

  def edit
    @cost_range = CostRange.find(params[:id])
  end

  def update
    @cost_range = CostRange.find_by_id(params[:id])
    if @cost_range
      check = @cost_range.update(check_cost_range_params)
      if check
        redirect_to admin_cost_range_index_path, :flash => { :notice =>  'Successfully updated' }
      else
        redirect_to admin_cost_range_index_path, :flash => { :error => 'an error occured' }
      end
    else
      redirect_to admin_cost_range_index_path, :flash => { :error => 'cannot be deleted' }
    end
  end

  def index
    @cost_ranges = CostRange.all
  end

  def delete
    @cost_range = CostRange.find_by_id(params[:id])
    if @cost_range
      @cost_range.destroy
      redirect_to admin_cost_range_index_path, :flash => { :notice =>  'Successfully Deleted' }
    else
      redirect_to admin_cost_range_index_path, :flash => { :error => 'cannot be deleted' }
    end
  end

  private
  def check_cost_range_params
    params.permit(:quality, :range1, :range2, :currency)
  end
end
