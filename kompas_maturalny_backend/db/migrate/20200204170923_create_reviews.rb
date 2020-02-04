class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.integer :rate
      t.belongs_to :user
      t.timestamps
    end

    add_reference :reviews, :reviewable, polymorphic: true, index: true
    add_index :reviews, %i[user_id reviewable_id], unique: true
  end
end
