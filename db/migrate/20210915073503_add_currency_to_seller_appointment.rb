class AddCurrencyToSellerAppointment < ActiveRecord::Migration[6.1]
  def change
    add_column :seller_appointments, :currency, 'char(12)'
  end
end
