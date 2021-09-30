class Admin::SellerAppointmentController < ApplicationController

  before_action :authorize_admin


  def new

  end

  def create
  end


  def edit
    @seller_appointment = SellerAppointment.find(params[:id])
  end

  def update
    seller_appointment = helpers.params_check_seller_appointment(params)
    @seller_appointment = SellerAppointment.find(params[:id])
    @seller_appointment.status = params[:status]
    check= @seller_appointment.changed?
    p = @seller_appointment.update(seller_appointment)
    if p
      if check
        SellerMailer.appointment_updates_mail(@seller_appointment).deliver
      end
    end
    redirect_to admin_seller_appointment_index_path
  end

  def index
    @seller_appointments = SellerAppointment.all.order('updated_at DESC')
  end

  def show
    @seller_appointment = SellerAppointment.find(params[:id])
    render 'view'
  end

  def delete
    SellerAppointment.destroy(params[:id])
    redirect_to admin_seller_appointment_index_path
  end
end
