class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.string :nickname
      t.string :stripe_pm_id
      t.string :stripe_user_id
      t.string :stripe_token
      t.string :brand
      t.string :last4
      t.string :exp_month
      t.string :exp_year
      t.integer :status, default: 1
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
