class AddDescriptionToFaves < ActiveRecord::Migration
  def change
    add_column :faves, :description, :string
  end
end
