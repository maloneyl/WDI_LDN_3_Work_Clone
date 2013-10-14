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

  def create(params)
    @connection.exec("INSERT INTO movies (title, year, rated, poster, director, actors)
    VALUES ('#{params[:title]}', '#{params[:year]}', '#{params[:rated]}', '#{params[:poster]}', '#{params[:director]}', '#{params[:actors]}') RETURNING id")[0]["id"]
  end

  def search(query)
    @connection.exec "SELECT * FROM movies WHERE title ILIKE '%#{query}%'"
  end

  def update(params)
    @connection.exec "UPDATE movies SET
     title = '#{params[:title]}',
     year = '#{params[:year]}',
     rated = '#{params[:rated]}', 
     poster = '#{params[:poster]}',
     director = '#{params[:director]}', 
     actors = '#{params[:actors]}' 
     WHERE id = #{params[:movie_id]}"
  end

  def delete(id)
    @connection.exec "DELETE FROM movies WHERE id = #{id}"
  end
    
end
