class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    change_column_null :users, :username, false
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :integer
    add_column :users, :city, :string
    add_column :users, :account_type, :integer
    change_column_null :users, :account_type, false
    add_column :users, :date_of_matura, :date
  end
end
