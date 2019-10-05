class AddUniqueIndexToMaturaResults < ActiveRecord::Migration[5.2]
  def change
    add_index :matura_results, [:user_id, :matura_subject_id, :level], unique: true, name: 'unique_matura_subject'
  end
end
