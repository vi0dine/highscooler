class AddIndexToStudyInterests < ActiveRecord::Migration[5.2]
  def change
    add_index :study_interests, %i[user_id field_of_study_id], unique: true
  end
end
