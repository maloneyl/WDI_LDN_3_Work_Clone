# possible use case of class methods

class Post

  attr_accessor :title, :content, :author

  def self.search search_term
    DB.find_related_post search_term # fake, just for example
  end

end

posts = Posts.search "Ruby is cool"  # then it'll return all related instances
