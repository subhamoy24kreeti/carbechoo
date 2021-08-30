class CreateCarVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :car_variants do |t|
      t.string :variant, null: false
      t.timestamps
    end
  end
end
