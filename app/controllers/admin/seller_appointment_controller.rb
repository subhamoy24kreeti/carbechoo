class Admin::SellerAppointmentController < ApplicationController

  include Admin::SellerAppointmentHelper
  before_action :authorize_admin


  def new
  end

  def create
  end


  def edit
    @seller_appointment = SellerAppointment.find(params[:id])
  end

  def update
    @seller_appointment = SellerAppointment.find_by_id(params[:id])
    if @seller_appointment
      check = @seller_appointment.update_seller_appointment(params_check_seller_appointment(params))
      if check
        redirect_to admin_seller_appointment_index_path, :flash => { :notice =>  'Scccessfully updated' }
      else
        redirect_to admin_seller_appointment_index_path,  :flash => { :error => 'there is some error' }
      end
    else
      redirect_to admin_seller_appointment_index_path,  :flash => { :error => 'cannot be updated' }
    end
  end

  def index
    @seller_appointments = SellerAppointment.all.order('updated_at DESC')
  end

  def show
    @seller_appointment = SellerAppointment.find(params[:id])
    render 'view'
  end

  def delete
    @seller_appointment = SellerAppointment.find_by_id(params[:id])
    if @seller_appointment
      @seller_appointment.destroy
      redirect_to admin_seller_appointment_index_path, :flash => { :notice => "Succesfully deleted" }
    else
      redirect_to admin_seller_appointment_index_path, :flash => { :error => "cannot be deleted" }
    end
  end
end
