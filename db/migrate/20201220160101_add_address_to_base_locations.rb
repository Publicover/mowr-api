class AddAddressToBaseLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :base_locations, :line_1, :string
    add_column :base_locations, :line_2, :string
    add_column :base_locations, :city, :string
    add_column :base_locations, :state, :string
    add_column :base_locations, :zip, :string
    add_column :base_locations, :latitude, :decimal, precision: 10, scale: 6
    add_column :base_locations, :longitude, :decimal, precision: 10, scale: 6
  end
end
