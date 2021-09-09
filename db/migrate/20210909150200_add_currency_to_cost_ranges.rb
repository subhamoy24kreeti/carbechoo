class AddCurrencyToCostRanges < ActiveRecord::Migration[6.1]
  def change
    add_column :cost_ranges, :currency, 'char(12)' 
  end
end
