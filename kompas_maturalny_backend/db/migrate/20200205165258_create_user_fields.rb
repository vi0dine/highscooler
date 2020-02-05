class CreateUserFields < ActiveRecord::Migration[6.0]
  def change
    create_table :user_fields do |t|
      t.belongs_to :user
      t.belongs_to :field_of_study
      t.timestamps
    end

    add_index :user_fields, [:user_id, :field_of_study_id], unique: true
  end
end
