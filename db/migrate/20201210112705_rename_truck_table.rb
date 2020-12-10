class RenameTruckTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :trucks, :plows
  end
end
