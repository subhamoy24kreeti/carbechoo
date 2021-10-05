class Admin::BuyerAppointmentController < ApplicationController

  include Admin::BuyerAppointmentHelper
  before_action :authorize_admin

  def edit
    @statuses = [['processing',0], ['scheduled', 1], ['rejected', 2], ['sold out', 3]]
    @buyer_appointment = BuyerAppointment.find(params[:id])
  end

  def update
    @buyer_appointment = BuyerAppointment.find(params[:id])
    check = @buyer_appointment.update_buyer_appointment(update_buyer_appointment_params(params))
    if check
      redirect_to admin_buyer_appointment_index_path, flash: {notice: 'Scccessfully updated' }
    else
      redirect_to admin_buyer_appointment_index_path, flash: {error: 'there is some error' }
    end
  end

  def index
    @buyer_appointments = BuyerAppointment.all
  end

  def show
    BuyerAppointment.find(params[:id])
    render 'view'
  end

  def destroy
    check = BuyerAppointment.destroy(params[:id])
    if check
      redirect_to admin_buyer_appointment_index_path, flash: { notice: 'successfully deleted'}
    else
      redirect_to admin_buyer_appointment_index_path, flash: {notice: 'there is some thing wrong while deleting'}
    end
  end
end
