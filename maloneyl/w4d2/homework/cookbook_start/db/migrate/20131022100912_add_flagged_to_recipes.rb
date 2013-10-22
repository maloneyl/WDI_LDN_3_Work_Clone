class AddFlaggedToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :flagged, :boolean
  end
end
