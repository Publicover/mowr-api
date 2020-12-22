class ChangeTotalCostTypeInServiceDeliveries < ActiveRecord::Migration[6.0]
  def change
    remove_column :service_deliveries, :total_cost, :decimal, precision: 5, scale: 2
  end
end
