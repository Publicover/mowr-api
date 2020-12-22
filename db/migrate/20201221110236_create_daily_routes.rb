class CreateDailyRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_routes do |t|
      t.integer :deliveries_in_order, defaul: [], array: true

      t.timestamps
    end
  end
end
