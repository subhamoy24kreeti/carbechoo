class Admin::CostRangeController < ApplicationController

    before_action :authorize_admin
    
    def new
        @cost_range = CostRange.new
    end

    def create
        quality = params[:quality]
        cost_range1 = params[:range1]
        cost_range2 = params[:range2]
        currency = params[:currency]
        @cost_range = CostRange.new(quality: quality, range1: cost_range1, range2: cost_range2, currency: currency)
        if(@cost_range.save)
            redirect_to new_admin_cost_range_path, notice: "you are successfully created a cost range"
        else
            redirect_to new_admin_cost_range_path, notice: "sorry there is a problem of creating cost range"
        end
    end

    def edit 
        @cost_range = CostRange.find_by_id(params[:id])
    end

    def update
        quality = params[:quality]
        cost_range1 = params[:range1]
        cost_range2 = params[:range2]
        currency = params[:currency]
        CostRange.where(id: params[:id]).update(quality: quality, range1: cost_range1, range2: cost_range2, currency: currency)
        redirect_to admin_cost_range_index_path, notice: "you are successfully created a cost range"
    end

    def index
        @cost_ranges = CostRange.all
    end

    def delete
        CostRange.destroy(params[:id])
        redirect_to admin_cost_range_index_path
    end
end
