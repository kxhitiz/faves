class AddUserIdToFaves < ActiveRecord::Migration
  def change
    add_column :faves, :user_id, :integer
  end
end
