class BuyerAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :seller_appointment, optional: true

  def get_status_code
    statuses = { 'processing' => 0,'scheduled' => 1, 'rejected' => 2, 'sold out'=> 3 }
    return statuses[self.status]
  end
end
