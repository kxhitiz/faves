class CreateFaves < ActiveRecord::Migration
  def change
    create_table :faves do |t|
      t.string :url

      t.timestamps
    end
  end
end
