class CreateCarRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :car_registrations do |t|
      t.string :state_code
      t.timestamps
    end
  end
end
