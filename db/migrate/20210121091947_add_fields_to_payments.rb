class AddFieldsToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :stripe_user_id, :string
    add_column :payments, :payment_method_id, :string
    add_column :payments, :last4, :string
    add_column :payments, :receipt_url, :string
  end
end
