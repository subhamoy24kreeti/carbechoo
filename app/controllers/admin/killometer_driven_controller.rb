class Admin::KillometerDrivenController < ApplicationController

	before_action :authorize_admin

	def new
		@killometer_driven = KillometerDriven.new
	end

	def create
		p = KillometerDriven.new(killometer_range: params[:killometer_range])
		if p.save
			redirect_to new_admin_killometer_driven_path, flash: {notice: "Successfully updated"}
		else
			redirect_to new_admin_killometer_driven_path, flash: {error: 'an error occured' }
		end
	end

	def edit
		@killometer_driven = KillometerDriven.find_by_id(params[:id])
	end

	def update
		check = KillometerDriven.where(id: params[:id]).update(killometer_range: params[:killometer_range])

		if check
			redirect_to admin_killometer_driven_index_path, lash: {error: 'Successfully created' }
		else
			redirect_to admin_killometer_driven_index_path, flash: {error: 'an error occured' }
		end
	end

	def delete
		KillometerDriven.destroy(params[:id])
		redirect_to admin_killometer_driven_index_path
	end

	def index
		@killometer_drivens = KillometerDriven.all()
	end
end
