class CreateHighSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :high_schools do |t|
      t.string :name, null: false, unique: true
      t.string :city, null: false
      t.integer :school_type, null: false
      t.timestamps
    end
  end
end
