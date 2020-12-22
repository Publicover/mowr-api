class AddServiceSubtotalToServiceRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :service_requests, :service_subtotal, :decimal, precision: 5, scale: 2
  end
end
