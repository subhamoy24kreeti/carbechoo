class CreateCarRegistrationYears < ActiveRecord::Migration[6.1]
  def change
    create_table :car_registration_years do |t|
      t.string :range1, null: false
      t.string :range2, null: false
      t.timestamps
    end
  end
end
