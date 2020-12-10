class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.decimal :cost
      t.time :time_estimate

      t.timestamps
    end
  end
end
