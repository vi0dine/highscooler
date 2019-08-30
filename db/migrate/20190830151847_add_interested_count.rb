class AddInterestedCount < ActiveRecord::Migration[5.2]
  def change
    add_column :field_details, :interested_count, :integer, default: 0
    add_column :users, :interested_count, :integer, default: 0
  end
end
