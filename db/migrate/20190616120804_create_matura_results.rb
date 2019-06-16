class CreateMaturaResults < ActiveRecord::Migration[5.2]
  def change
    create_table :matura_results do |t|
      t.belongs_to :user, index: true
      t.string :subject
      t.integer :level
      t.integer :result
      t.timestamps
    end
  end
end
