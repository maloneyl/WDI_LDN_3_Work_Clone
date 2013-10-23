class CreateSearches < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE VIEW searches AS
        SELECT authors.id AS searchable_id, authors.full_name AS term,
        CAST ('Author' AS varchar) AS searchable_type
        FROM authors
        UNION
        SELECT authors.id AS searchable_id, authors.bio AS term,
        CAST ('Author' AS varchar) AS searchable_type
        FROM authors        
        UNION
        SELECT posts.id AS searchable_id, posts.title AS term,
        CAST ('Post' AS varchar) AS searchable_type
        FROM posts
        UNION
        SELECT posts.id AS searchable_id, posts.content AS term,
        CAST ('Post' AS varchar) AS searchable_type
        FROM posts
        UNION
        SELECT posts.id AS searchable_id, posts.category AS term,
        CAST ('Post' AS varchar) AS searchable_type
        FROM posts 
    SQL
  end

  def down
  end
end
