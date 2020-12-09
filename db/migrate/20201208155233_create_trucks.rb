class CreateTrucks < ActiveRecord::Migration[6.0]
  def change
    create_table :trucks do |t|
      t.string :licence_plate
      t.string :year
      t.string :color
      t.string :make
      t.string :model
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
