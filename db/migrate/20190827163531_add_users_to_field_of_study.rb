class AddUsersToFieldOfStudy < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :field_of_study, foreign_key: true
  end
end
