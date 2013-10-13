class Actor

  def initialize(connection)
    @connection = connection
  end

  def all
    @connection.exec "SELECT * FROM actors" # 'return' is implicit
  end

  def find(id)
    @connection.exec("SELECT * FROM actors WHERE id = #{id}").first
  end

  def create(params)
    @connection.exec("INSERT INTO actors (first_name, last_name, dob, image_url) VALUES
      ('#{params[:first_name]}', '#{params[:last_name]}', '#{params[:dob]}', '#{params[:image_url]}') RETURNING id")[0]["id"]
  end

  def search(query)
    @connection.exec "SELECT * FROM actors WHERE first_name ILIKE '%#{query}%' OR last_name LIKE '%#{query}%'"
  end

  def update(params)
    @connection.exec "UPDATE actors SET
      first_name = '#{params[:first_name]}',
      last_name = '#{params[:last_name]}',
      dob = '#{params[:dob]}',
      image_url = '#{params[:image_url]}'
      WHERE id = #{params[:actor_id]}"
  end  

  def delete(id)
    @connection.exec "DELETE FROM actors WHERE id = #{id}"
  end

end