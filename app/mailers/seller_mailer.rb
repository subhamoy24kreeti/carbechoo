class SellerMailer < ApplicationMailer

  default from: 'notifications@carbechoo.com'

  def welcome_mail(user)
    @user = user
    mail(to: @user.email, subject: "Successfully registred at carbechoo")
  end

  def appointment_submission_mail(user, appointment_id)
    @user = user
    @appointment_id = appointment_id
    mail(to: @user.email, subject: "Successfully submitted car details")
  end

  def appointment_updates_mail(appointment)
    @appointment = appointment
    mail(to: @appointment.user.email, subject: 'Selling Appointment Updates')
  end
  
end
