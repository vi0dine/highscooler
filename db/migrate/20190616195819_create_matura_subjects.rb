class CreateMaturaSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :matura_subjects do |t|
      t.string :name
      t.integer :subject_type
      t.timestamps
    end
  end
end
