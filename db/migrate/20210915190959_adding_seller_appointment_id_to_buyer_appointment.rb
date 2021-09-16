class AddingSellerAppointmentIdToBuyerAppointment < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :buyer_appointments, column: :seller_user_id
    remove_column :buyer_appointments, :seller_user_id, :bigint
    add_reference :buyer_appointments, :seller_appointment, foreign_key: true
  end
end
