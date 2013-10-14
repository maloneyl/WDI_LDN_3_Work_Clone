class Movie

  def initialize(connection)
    @connection = connection
  end

  def all
    @connection.exec "SELECT * FROM movies" # 'return' is implicit
  end

  def find(id)
    @connection.exec("SELECT * FROM movies WHERE id = #{id}").first
  end

  def actor(id)
    @connection.exec "SELECT * FROM actors INNER JOIN actors_movies ON actors_movies.actor_id = actors.id WHERE actors_movies.movie_id = #{id}"
  end

  def create(params)
    @connection.exec("INSERT INTO movies (title, year, rated, genre, poster, director, writers, actors)
    VALUES ('#{@connection.escape params[:title]}', '#{params[:year]}', '#{params[:rated]}', '#{params[:genre]}', '#{params[:poster]}', '#{params[:director]}', '#{params[:writers]}', '#{params[:actors]}') RETURNING id")[0]["id"]
  end

  def search(query)
    @connection.exec "SELECT * FROM movies WHERE title ILIKE '%#{query}%'"
  end

  def update(params)
    @connection.exec "UPDATE movies SET
     title = '#{@connection.escape params[:title]}',
     year = '#{params[:year]}',
     rated = '#{params[:rated]}', 
     genre = '#{params[:genre]}',
     poster = '#{params[:poster]}',
     director = '#{params[:director]}', 
     writers = '#{params[:writers]}',
     actors = '#{params[:actors]}' 
     WHERE id = #{params[:movie_id]}"
    @connection.exec "INSERT INTO actors_movies (actor_id, movie_id) VALUES (#{params[:actor_to_add]}, #{params[:movie_id]})" unless params[:actor_to_add] == ''
  end

  def delete(id)
    @connection.exec "DELETE FROM movies WHERE id = #{id}"
  end

end
