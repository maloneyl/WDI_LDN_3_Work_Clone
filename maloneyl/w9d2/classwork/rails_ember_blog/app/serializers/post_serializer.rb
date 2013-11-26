class PostSerializer < ActiveModel::Serializer

  # specify what to ship in our API/JSON
  # includes the fields in our Post model by default - we can exclude any of those if we want to
  # and we can add more/change names as long as we write our own functions below
  attributes :id, :url, :title, :body, :date

  embed :ids, include: true # sideload the users (i.e. send the id in the posts object, then also include the list of users to be referenced)
  has_one :user, key: :author_id # has_one or belongs_to is just has_one in Serializer
  # we'd send the info related to the user too
  # :author_id is what Ember would want given our user model there

  # grab the URL of a post to then include as an attribute to send with our JSON
  def url
    post_url object # object is the current instance of the object being serialized
  end
  # we can see from http://localhost:3000/posts.json that 'url: "http://localhost:3000/posts/1"'

  # reminder: our Post model in Rails has content, vs. Ember's body
  def body
    object.content
  end

  # reminder: our Post model in Rails has created_at, vs. Ember's date
  def date
    # object.created_at # that would be a Date object
    object.created_at.getutc.iso8601 # standard format so that other programs can format however they want
  end

end
