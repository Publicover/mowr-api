class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.decimal :price_per_quarter_hour, precision: 5, scale: 2

      t.timestamps
    end
  end
end
