class ChangeRequestsToServiceRequests < ActiveRecord::Migration[6.0]
  def change
    rename_table :requests, :service_requests
  end
end
