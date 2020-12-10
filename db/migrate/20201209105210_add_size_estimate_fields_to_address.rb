class AddSizeEstimateFieldsToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :estimate_complete, :boolean, default: false 
    add_column :addresses, :estimate_confirmed, :boolean, default: false
    add_column :addresses, :actual_acreage, :string, default: false
  end
end
