class AutoTagWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3 # because we're dealing with an API here and it's worth retrying

  def perform(post_id)
    open_calais = OpenCalais::Client.new(:api_key=>ENV['OPENCALAIS_API_KEY'])
    p = Post.find(post_id)
    text = [p.title, p.content].join(" ") # i.e. analyze both post title and post content
    response = open_calais.enrich(text)
    tags = response.tags.map { |t| t[:name] } # each tag is a hash and we just want to get the name field out of it
    p.tag_list.add(tags) # i.e. add tags from OpenCalais AND keep the user's own tags filled in
    p.save! # ! because it might fail silently so we want to have the error message to go to our Failures section of the Sidekiq dashboard
  end

end
