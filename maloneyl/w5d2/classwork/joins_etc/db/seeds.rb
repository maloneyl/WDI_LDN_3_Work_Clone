def random_datetime(options={})
  end_time = Time.now
  start_time = options[:start_time] || end_time.send(:ago, (options[:interval] || 15.days))
  Time.at((end_time.to_f - start_time.to_f)*rand + start_time.to_f)
end

Category.delete_all
Post.delete_all
Tag.delete_all
Guest.delete_all
Comment.delete_all

categories = %w(personal work family fun).map {|category| Category.create! name: category }

tags = %w(ruby rails programming fun sql orm javascript bbq movie).map { |tag| Tag.create! name: tag }



posts = ['new year resolutions', 'january weather', 'movie reviews', 'easter overload', 'spring sunburn'].map {|post| Post.create! name: post, category_id: categories.sample.id, published_at: random_datetime }

posts.each { |post| post.tags << tags.sample(rand(tags.length)) }

comments = (1..20).map do |i| 
  post = posts.sample
  Comment.create! comment: "comment #{i}", post_id: post.id, published_at: random_datetime(start_time: post.published_at)
end

guests = %w(gerry jon julien david sharif neha rob jamie)
comments.each { |comment| Guest.create! name: guests.sample, comment_id: comment.id }




