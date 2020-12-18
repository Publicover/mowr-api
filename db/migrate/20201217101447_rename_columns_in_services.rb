class RenameColumnsInServices < ActiveRecord::Migration[6.0]
  def change
    rename_column :services, :price_per_quarter_hour, :price_per_sq_ft
    add_column :services, :price_per_inch_of_snow, :decimal, precision: 5, scale: 2
    add_column :services, :price_per_season, :decimal, precision: 5, scale: 2
  end
end
