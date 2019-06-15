class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :gender
      t.date :date_of_birth
      t.string :city
      t.date :date_of_matura, null: false
      t.integer :account_type, null: false

      t.timestamps
    end
  end
end
