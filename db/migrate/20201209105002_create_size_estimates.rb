class CreateSizeEstimates < ActiveRecord::Migration[6.0]
  def change
    create_table :size_estimates do |t|
      t.decimal :acreage, precision: 5, scale: 2
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
