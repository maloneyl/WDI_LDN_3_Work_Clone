class CreateSearches < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE VIEW searches AS
        SELECT recipes.id AS searchable_id, recipes.name AS term,
        CAST ('Recipe' AS varchar) AS searchable_type
        FROM recipes
        UNION
        SELECT recipes.id AS searchable_id, recipes.course AS term,
        CAST ('Recipe' AS varchar) AS searchable_type
        FROM recipes
        UNION
        SELECT recipes.id AS searchable_id, recipes.instructions AS term,
        CAST ('Recipe' AS varchar) AS searchable_type
        FROM recipes
        UNION
        SELECT ingredients.id AS searchable_id, ingredients.name AS term,
        CAST ('Ingredient' AS varchar) AS searchable_type
        FROM ingredients
    SQL
  end
  
  def down
  end
end
