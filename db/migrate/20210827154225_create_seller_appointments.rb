class CreateSellerAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :seller_appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false ,default: "processing"
      t.date :scheduled_date
      t.time :scheduled_time
      t.timestamps
    end
  end
end
