module Admin::BuyerAppointmentHelper

  def update_buyer_appointment_params(params)
    buyer_appointment = {}
    statuses = ['processing', 'scheduled', 'sold out', 'rejected']
    if !params[:status].blank?
      params[:status] = statuses[params[:status].to_i]
    end
    buyer_appointment[:status] = params[:status]
    buyer_appointment[:scheduled_date] = params[:scheduled_date]
    buyer_appointment[:scheduled_time] = params[:scheduled_time]
    buyer_appointment
  end
end
