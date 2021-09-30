class BuyerController < ApplicationController

  before_action :buyer_authorization, except: [:new, :create]

  def buyer_authorization
    if current_user.blank?
      redirect_to root_path and return
    end
    if current_user.role == 'seller'
      redirect_to seller_dashboard_path and return
    end
  end

  def new
    render 'signup'
  end

  #buyer sign up controller
  def create
    @buyer = User.new(buyer_create_parmas_check)
    if @buyer.save
      session[:user_id] = @buyer.id
      BuyerMailer.welcome_mail(@buyer).deliver
      UserMailer.email_verification_mail(@buyer).deliver
      redirect_to buyer_dashboard_path, flash: { notice: "Successfully Created! account" }
    else
      redirect_to buyer_registration_path, flash: { error: @buyer.errors.full_messages }
    end
  end

  #buyer appointment creation controller
  def create_appointment
    buyer_appointment = BuyerAppointment.new(user_id: current_user.id, seller_appointment_id: params[:seller_appointment_id]);
    if buyer_appointment.save
      BuyerMailer.appointment_submission_mail(current_user, buyer_appointment.id).deliver
      render 'appointment_success', flash: { info: "Successfully created an appointment" }
    else
      redirect_to car_single_path(params[:seller_appointment_id]), flash: { error: "Do not create appointment" }
    end
  end

  #buyer show my appointments
  def all_appointments
    @all_buyer_appointments = BuyerAppointment.where(user_id: params[:id])
    render "all_appointments"
  end

  #buyer dashboard
  def dashboard
  end

  def parmas_check_buyer_appointment_check
    params.require(:buyer).permit(:first_name, :last_name, :email, :password, :password_confirmation, :country_id, :state_id, :city_id, :zip_code).merge!(role: 'buyer')
  end

end
