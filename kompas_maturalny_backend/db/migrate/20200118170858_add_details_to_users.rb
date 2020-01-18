class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :integer
    add_column :users, :city, :string
    add_column :users, :role, :integer
    add_column :users, :date_of_matura, :date
  end
end
