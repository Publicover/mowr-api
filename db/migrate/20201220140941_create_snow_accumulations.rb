class CreateSnowAccumulations < ActiveRecord::Migration[6.0]
  def change
    create_table :snow_accumulations do |t|
      t.integer :inches

      t.timestamps
    end
  end
end
