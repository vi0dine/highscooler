class CreateMaturaResults < ActiveRecord::Migration[6.0]
  def change
    create_table :matura_results do |t|
      t.belongs_to :user
      t.belongs_to :matura_subject
      t.integer :result
      t.timestamps
    end
  end
end
