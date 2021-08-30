class CreateCarModels < ActiveRecord::Migration[6.1]
  def change
    create_table :car_models do |t|
      t.references :brand, null: false, foreign_key: true, on_delete: :cascade
      t.string :name
      t.timestamps
    end
  end
end
