class AddFieldsCountToAcademy < ActiveRecord::Migration[5.2]
  def up
    add_column :academies, :field_of_studies_count, :integer, null: false, default: 0

    execute <<-SQL
      UPDATE academies
      SET field_of_studies_count = (
        SELECT COUNT(1)
        FROM field_details
        WHERE field_details.academy_id = academies.id
      )
    SQL
  end

  def down
    remove_column :academies, :field_of_studies_count
  end
end
