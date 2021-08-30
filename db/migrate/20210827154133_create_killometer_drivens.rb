class CreateKillometerDrivens < ActiveRecord::Migration[6.1]
  def change
    create_table :killometer_drivens do |t|
      t.string :killometer_range, null: false
      t.timestamps
    end
  end
end
