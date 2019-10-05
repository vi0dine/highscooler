class AddAcademiesCountToFieldOfStudies < ActiveRecord::Migration[5.2]
  def change
    add_column :field_of_studies, :academies_count, :integer, null: false, default: 0
  end
end
