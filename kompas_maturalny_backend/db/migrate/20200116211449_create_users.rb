class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, null: false
      t.string :password_digest, null: false
      t.datetime :date_of_birth
      t.datetime :date_of_matura
      t.integer :gender
      t.string :city
      t.integer :role, null: false
    end
  end
end
