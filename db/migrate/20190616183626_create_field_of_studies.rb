class CreateFieldOfStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :field_of_studies do |t|
      t.string :name
      t.integer :field_type
      t.timestamps
    end
  end
end
