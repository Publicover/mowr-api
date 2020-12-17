class CreateEarlyBirds < ActiveRecord::Migration[6.0]
  def change
    create_table :early_birds do |t|
      t.integer :priority, default: 1
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
