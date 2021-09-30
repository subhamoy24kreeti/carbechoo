class Admin::CarModelController < ApplicationController

	before_action :authorize_admin

	def new
		@car_model = CarModel.new
		@brands = Brand.all()
	end

	def create
		p = CarModel.new(brand_id: params[:brand_id],name: params[:name])
		if p.save
			redirect_to new_admin_car_model_path, flash: {notice: "successfully created"}
		else
			redirect_to new_admin_car_model_path, flash: {error: "en error occured"}
		end
	end

	def edit
		@brands = Brand.all.map{|brand| [brand.brand_name, brand.id]}
		@car_model = CarModel.find(params[:id])
	end

	def update
		check = CarModel.where(id: params[:id]).update(brand_id: params[:brand_id], name: params[:name])
		if check
			redirect_to admin_car_model_index_path, flash: {notice: "Successfully updated"}
		else
			redirect_to admin_car_model_index_path, flash: {error: "an error occured"}
		end
	end

	def delete
		p = CarModel.destroy(params[:id])
		if p
			redirect_to admin_car_model_index_path, flash: {notice: "successfully deleted"}
		else
			redirect_to admin_car_model_index_path, flash: {error: "an error occured"}
		end
	end

	def index
		@car_models = CarModel.all
	end
end
