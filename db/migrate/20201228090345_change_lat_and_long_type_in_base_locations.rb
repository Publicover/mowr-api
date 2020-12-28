class ChangeLatAndLongTypeInBaseLocations < ActiveRecord::Migration[6.0]
  def change
    change_column :base_locations, :latitude, :decimal, precision: 10, scale: 6
    change_column :base_locations, :longitude, :decimal, precision: 10, scale: 6
  end
end
