class ChangeSquareFootageInSizeEstimates < ActiveRecord::Migration[6.0]
  def change
    change_column :size_estimates, :square_footage, :decimal, precision: 6, scale: 2
  end
end
