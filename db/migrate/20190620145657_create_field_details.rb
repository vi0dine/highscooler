class CreateFieldDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :field_details do |t|
      t.belongs_to :academy, index: true
      t.belongs_to :field_of_study, index: true
      t.integer :students_limit
      t.string :recrutation_formula
      t.integer :minimal_points
      t.timestamps
    end
  end
end