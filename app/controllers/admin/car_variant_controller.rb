class Admin::CarVariantController < ApplicationController

	before_action :authorize_admin

	def new
		@car_variant = CarVariant.new
	end

	def create
		p = CarVariant.new(variant: params[:variant])
		if p.save
			redirect_to new_admin_car_variant_path, flash: {notice: "Successfully updated"}
		else
			redirect_to new_admin_car_variant_path, flash: {error: 'an error occured' }
		end
	end

	def update
		check = CarVariant.where(id: params[:id]).update(variant: params[:variant])
		if check
			redirect_to admin_car_variant_index_path, flash: {notice: "Successfully updated"}
		else
			redirect_to admin_car_variant_index_path, flash: {error: 'an error occured' }
		end
	end

	def edit
		@car_variant = CarVariant.find(params[:id])
	end

	def delete
		p = CarVariant.destroy(params[:id])
		redirect_to admin_car_variant_index_path
	end

	def index
		@car_variants = CarVariant.all()
	end

end
