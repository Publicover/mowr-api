class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :cost_in_cents
      t.string :stripe_charge_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
