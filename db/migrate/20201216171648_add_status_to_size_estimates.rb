class AddStatusToSizeEstimates < ActiveRecord::Migration[6.0]
  def change
    add_column :size_estimates, :status, :integer, default: 0
  end
end
