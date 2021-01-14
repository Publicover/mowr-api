class AddStatusToServiceDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :service_deliveries, :status, :integer, default: 0
  end
end
