class CreateAcademies < ActiveRecord::Migration[5.2]
  def change
    create_table :academies do |t|
      t.string :name, null: false, unique: true
      t.string :city, null: false
      t.integer :academy_type, null: false
      t.timestamps
    end
  end
end
