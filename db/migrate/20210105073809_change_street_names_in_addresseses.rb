class ChangeStreetNamesInAddresseses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :line_1, :line1
    rename_column :addresses, :line_2, :line2
  end
end
