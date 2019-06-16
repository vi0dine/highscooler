class CreateStudyInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :study_interests do |t|
      t.belongs_to :field_of_study, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
