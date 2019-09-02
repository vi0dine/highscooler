class CreateFieldOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :field_opinions do |t|
      t.text :body, null: false
      t.boolean :is_positive, null: false
      t.belongs_to :user
      t.belongs_to :field_of_study
      t.belongs_to :academy
      t.timestamps
    end
    add_index :field_opinions, [:academy_id, :field_of_study_id, :user_id], unique: true, name: 'one_field_opinion'
  end
end
