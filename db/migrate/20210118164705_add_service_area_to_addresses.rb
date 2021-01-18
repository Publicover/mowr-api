class AddServiceAreaToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :service_address, :integer
  end
end
