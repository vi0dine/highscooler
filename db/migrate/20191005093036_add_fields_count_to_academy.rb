class AddFieldsCountToAcademy < ActiveRecord::Migration[5.2]
  def change
    add_column :academies, :field_of_studies_count, :integer, null: false, default: 0
  end
end
