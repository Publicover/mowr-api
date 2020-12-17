class AddStatusToServiceRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :service_requests, :status, :integer, default: 0
  end
end
