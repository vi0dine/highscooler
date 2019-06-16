class AddBelongsToToMaturaResult < ActiveRecord::Migration[5.2]
  def change
    remove_column :matura_results, :subject, :string
    add_reference :matura_results, :matura_subject, foreign_key: true
  end
end
