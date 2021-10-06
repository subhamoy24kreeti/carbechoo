class BuyerAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :seller_appointment

  after_create :appointment_creation_mail

  scope :all_appointments, ->(user_id) { where(user_id: user_id )}

  def get_status_code
    statuses = { 'processing' => 0,'scheduled' => 1, 'rejected' => 2, 'sold out'=> 3 }
    statuses[status]
  end

  def update_buyer_appointment(params)
    check = false
    if status != params[:status]
      check = true
    end

    if update(params)
      if check
        BuyerMailer.appointment_updates_mail(self).deliver
      end
      true
    else
      false
    end
  end

  private
  def appointment_creation_mail
    BuyerMailer.appointment_submission_mail(current_user, buyer_appointment.id).deliver
  end

end
