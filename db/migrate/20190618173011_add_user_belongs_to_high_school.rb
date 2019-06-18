class AddUserBelongsToHighSchool < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :high_school, foreign_key: true    
  end
end
