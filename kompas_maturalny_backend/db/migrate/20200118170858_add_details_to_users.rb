class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :date_of_birth, :datetime
    add_column :users, :gender, :integer
    add_column :users, :city, :string
    add_column :users, :role, :integer
    add_column :users, :date_of_matura, :datetime
  end
end
