class Admin::SellerAppointmentController < ApplicationController

    before_action :authorize_admin
    
    def new

    end

    def create
    end

    def edit 

    end

    def update

    end

    def index
        @seller_appointments = SellerAppointment.includes(:user, :city).all
    end

    def delete
        SellerAppointment.destroy(params[:id])
        redirect_to admin_seller_appointment_index_path
    end
end
