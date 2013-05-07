class AddPageTitleToFaves < ActiveRecord::Migration
  def change
    add_column :faves, :page_title, :string
  end
end
