class CreateInteresteds < ActiveRecord::Migration[5.2]
  def change
    create_table :interesteds do |t|
      t.belongs_to :field_detail, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
    add_index :interesteds, [:field_detail_id, :user_id], unique: true
  end
end
