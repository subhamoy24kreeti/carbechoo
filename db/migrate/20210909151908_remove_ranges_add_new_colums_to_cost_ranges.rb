class RemoveRangesAddNewColumsToCostRanges < ActiveRecord::Migration[6.1]
  def change
    remove_column :cost_ranges, :range, :text
    add_column :cost_ranges, :range1, :bigint
    add_column :cost_ranges, :range2, :bigint
  end
end
