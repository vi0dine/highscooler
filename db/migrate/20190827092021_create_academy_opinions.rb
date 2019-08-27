class CreateAcademyOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :academy_opinions do |t|
      t.text :body
      t.boolean :is_positive
      t.belongs_to :user
      t.belongs_to :academy
      t.timestamps
    end
  end
end
