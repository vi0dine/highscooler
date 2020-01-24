class CreateAcademies < ActiveRecord::Migration[6.0]
  def change
    create_table :academies do |t|
      t.string :name
      t.text :description
      t.string :city
      t.timestamps
    end
  end
end
