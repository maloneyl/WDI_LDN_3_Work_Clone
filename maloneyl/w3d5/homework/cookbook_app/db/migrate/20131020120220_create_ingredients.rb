class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.text :image
    end

    create_table :ingredients_recipes, id: false do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
    end 
  end
end
