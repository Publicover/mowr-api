class ReplaceForeignKeyFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :early_birds, :addresses
    add_foreign_key :early_birds, :addresses, on_delete: :cascade
  end
end
