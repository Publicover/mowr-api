class RenameDeliveriesInOrderInRoutes < ActiveRecord::Migration[6.0]
  def change
    rename_column :daily_routes, :deliveries_in_order, :addresses_in_order
  end
end
