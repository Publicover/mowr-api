class RemoveRecurringFromServiceRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :service_requests, :recurring, :boolean
  end
end
