class RenameAcreageInAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :size_estimates, :acreage, :square_footage
    rename_column :addresses, :actual_acreage, :actual_footage

  end
end
