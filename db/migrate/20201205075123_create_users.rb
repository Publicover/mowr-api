class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :f_name
      t.string :l_name
      t.string :password_digest
      t.integer :role

      t.timestamps
    end
  end
end
