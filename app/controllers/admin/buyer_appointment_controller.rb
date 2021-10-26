class Admin::BuyerAppointmentController < ApplicationController

  include Admin::BuyerAppointmentHelper
  before_action :authorize_admin

  def edit
    @buyer_appointment = BuyerAppointment.find(params[:id])
  end

  def update
    @buyer_appointment = BuyerAppointment.find_by_id(params[:id])
    if @buyer_appointment
      check = @buyer_appointment.update_buyer_appointment(update_buyer_appointment_params(params))
      if check
        redirect_to admin_buyer_appointment_index_path, :flash => { :notice => 'Scccessfully updated' }
      else
        redirect_to admin_buyer_appointment_index_path, :flash => { :error => 'an error occured' }
      end
    else
      edirect_to admin_buyer_appointment_index_path, :flash => { :error => 'cannot be updated' }
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
    @buyer_appointment = BuyerAppointment.find_by_id(params[:id])
    if @buyer_appointment
      @buyer_appointment.destroy
      redirect_to admin_buyer_appointment_index_path, :flash => { :notice => 'successfully deleted' }
    else
      redirect_to admin_buyer_appointment_index_path, :flash => { :notice => 'cannot be deleted' }
    end
  end
end
