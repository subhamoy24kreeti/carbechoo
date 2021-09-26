class Admin::BuyerAppointmentController < ApplicationController

  before_action :authorize_admin

  def edit
    @statuses = [['processing',0], ['scheduled', 1], ['rejected', 2], ['sold out', 3]]
    @buyer_appointment = BuyerAppointment.includes({seller_appointment: [:user ]}, :user).find(params[:id])
  end

  def update
    buyer_appointment = {}
    statuses = ['processing', 'scheduled', 'sold out', 'rejected']
    if !params[:status].blank?
      params[:status] = statuses[params[:status].to_i]
    end
    buyer_appointment[:status] = params[:status]
    buyer_appointment[:scheduled_date] = params[:scheduled_date]
    buyer_appointment[:scheduled_time] = params[:scheduled_time]

    @buyer_appointment = BuyerAppointment.includes({seller_appointment: [:user]}, :user).find(params[:id])
    @buyer_appointment.status = params[:status]
    check= @buyer_appointment.changed?
    p = @buyer_appointment.update(buyer_appointment)
    if p
      if check
        BuyerMailer.appointment_updates_mail(@buyer_appointment).deliver
      end
    end
    redirect_to admin_buyer_appointment_index_path, flash: {notice: 'Scccessfully updated' }
  end

  def index
    @buyer_appointments = BuyerAppointment.includes({seller_appointment: [:user, :car_model, :brand]}, :user).all
  end

  def show
    BuyerAppointment.includes({seller_appointment: [:user, :car_model, :brand]}, :user).find(params[:id])
    render 'view'
  end

  def destroy
    buyer_appointment = BuyerAppointment.includes({seller_appointment: [:user, :car_model, :brand]}, :user).find(params[:id])
    buyer_appointment.status = 'rejected'
    check = BuyerAppointment.destroy(params[:id])
    if check
      BuyerMailer.appointment_updates_mail(buyer_appointment).deliver
      redirect_to admin_buyer_appointment_index_path, flash: { notice: 'successfully deleted'}
    else
      redirect_to admin_buyer_appointment_index_path, flash: {notice: 'there is some thing wrong while deleting'}
    end

  end
end
