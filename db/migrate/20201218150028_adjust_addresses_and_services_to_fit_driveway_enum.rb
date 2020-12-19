class AdjustAddressesAndServicesToFitDrivewayEnum < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :actual_footage, :string
    remove_column :addresses, :integer, :string
    remove_column :addresses, :estimate_complete, :boolean
    remove_column :addresses, :estimate_confirmed, :boolean
    add_column :addresses, :driveway, :integer

    remove_column :service_requests, :approved, :boolean

    remove_column :services, :price_per_sq_ft, :decimal
    remove_column :services, :price_per_season
    add_column :services, :price_per_driveway, :integer, default: [], array: true
  end
end
