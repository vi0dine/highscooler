class CreateAcademyFields < ActiveRecord::Migration[6.0]
  def change
    create_table :academy_fields do |t|
      t.belongs_to :academy
      t.belongs_to :field_of_study
      t.string :recruitment_formula
      t.integer :students_limit
      t.timestamps
    end

    add_index :academy_fields, %i[academy_id field_of_study_id], unique: true
  end
end
