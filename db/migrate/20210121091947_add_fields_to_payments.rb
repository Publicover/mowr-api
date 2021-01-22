class AddFieldsToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :stripe_user_id, :string
    add_column :payments, :last4, :string
    add_column :payments, :receipt_url, :string
    add_reference :payments, :payment_method, index: true, foreign_key: true
  end
end
