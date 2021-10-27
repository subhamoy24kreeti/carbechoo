class BuyerController < ApplicationController

  include BuyerHelper
  before_action :buyer_authorization, except: [:new, :create]

  def new
    render 'signup'
  end

  # buyer sign up controller
  def create
    @buyer = User.new(buyer_create_parmas_check)
    if @buyer.save
      session[:user_id] = @buyer.id
      redirect_to buyer_dashboard_path, flash: { notice: "Successfully Created! account" }
    else
      redirect_to buyer_registration_path, flash: { error: @buyer.errors.full_messages }
    end
  end

  # buyer appointment creation controller
  def create_appointment
    buyer_appointment = BuyerAppointment.new(user_id: current_user.id, seller_appointment_id: params[:seller_appointment_id]);
    if buyer_appointment.save
      render 'appointment_success', flash: { notice: "Successfully created an appointment" }
    else
      redirect_to car_single_path(params[:seller_appointment_id]), flash: { error: "Do not create appointment" }
    end
  end

  # buyer show my appointments
  def all_appointments
    @all_buyer_appointments = BuyerAppointment.all_appointments(current_user.id)
  end

  # buyer dashboard
  def dashboard
  end

  private

  def buyer_create_parmas_check
    params.require(:buyer).permit(:first_name, :last_name, :email, :password, :password_confirmation, :country_id, :state_id, :city_id, :zip_code).merge!(role: 'buyer')
  end

end
