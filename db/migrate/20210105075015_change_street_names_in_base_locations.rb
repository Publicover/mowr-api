class ChangeStreetNamesInBaseLocations < ActiveRecord::Migration[6.0]
  def change
    rename_column :base_locations, :line_1, :line1
    rename_column :base_locations, :line_2, :line2
  end
end
