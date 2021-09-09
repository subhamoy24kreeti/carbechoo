class CreateCostRanges < ActiveRecord::Migration[6.1]
  def change
    create_table :cost_ranges do |t|
      t.string :quality
      t.string :range
      t.timestamps
    end
  end
end
