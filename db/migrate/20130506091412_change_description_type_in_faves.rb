class ChangeDescriptionTypeInFaves < ActiveRecord::Migration
  def up
    change_column :faves, :description, :text
  end

  def down
    change_column :faves, :descriptin, :string
  end
end
