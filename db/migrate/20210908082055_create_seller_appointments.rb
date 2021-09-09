class CreateSellerAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :seller_appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.references :car_model, null: false, foreign_key: true
      t.references :car_registration, null: false, foreign_key: true
      t.references :killometer_driven, null: false, foreign_key: true
      t.references :car_variant, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.string :zip_code
      t.references :cost_range, foreign_key:true
      t.string :year_of_buy
      t.bigint :price
      t.string :description
      t.string :status, null: false ,default: "processing"
      t.date :scheduled_date
      t.time :scheduled_time
      t.timestamps
    end
  end
end
