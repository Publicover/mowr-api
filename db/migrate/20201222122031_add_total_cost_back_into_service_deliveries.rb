class AddTotalCostBackIntoServiceDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :service_deliveries, :total_cost, :decimal, precision: 5, scale: 2
  end
end
