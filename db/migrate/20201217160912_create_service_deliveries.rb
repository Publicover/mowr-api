class CreateServiceDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :service_deliveries do |t|
      t.references :address, null: false, foreign_key: true
      t.string :total_cost

      t.timestamps
    end
  end
end
