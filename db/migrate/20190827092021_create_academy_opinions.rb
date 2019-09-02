class CreateAcademyOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :academy_opinions do |t|
      t.text :body, null: false
      t.boolean :is_positive, null: false
      t.belongs_to :user
      t.belongs_to :academy
      t.timestamps
    end
    add_index :academy_opinions, [:academy_id, :user_id], unique: true, name: 'one_academy_opinion'
  end
end
