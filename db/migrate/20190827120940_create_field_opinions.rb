class CreateFieldOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :field_opinions do |t|
      t.text :body
      t.boolean :is_positive
      t.belongs_to :user
      t.belongs_to :field_of_study
      t.belongs_to :academy
      t.timestamps
    end
  end
end
