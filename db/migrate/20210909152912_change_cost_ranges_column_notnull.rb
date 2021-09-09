class ChangeCostRangesColumnNotnull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :cost_ranges, :range1, false
    change_column_null :cost_ranges, :range2, false
    change_column_null :cost_ranges, :currency, false
    change_column_null :cost_ranges, :quality, false
  end
end
