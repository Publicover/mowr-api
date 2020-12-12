class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :address, null: false, foreign_key: true
      t.boolean :approved, default: false
      t.boolean :recurring, default: false
      t.integer :service_ids, default: [], array: true

      t.timestamps
    end
  end
end
