require 'mongo'
require 'faker'

client   = Mongo::MongoClient.new;
db       = client.db("demo_blog_app");
users    = db["users"];
posts    = db["posts"];
comments = db["comments"];

users.drop
posts.drop
comments.drop

alice = {
  name: "Alice",
  age: 25,
  address: "1 Main Street, London",
  hobbies: ["sailing", "walking"]
}

bob = {
  name: "Bob",
  age: 46,
  address: "2 Main Street, London",
  children: [
    {name:"Foo", age:10},
    {name:"Bar", age:8},
    {name:"Baz", age:5}
  ]
}

charlie = {
  name: "Charlie",
  age: 31,
  children: [
    {name:"Foo", age:5, hobbies: ["painting"]}
  ]
}

users.insert([alice, bob, charlie])

author_ids = users.find(name: {"$in" => ["Alice", "Bob"]}).map do |user|
  user["_id"]
end

commenter_ids = users.find(name: {"$in" => ["Alice", "Bob", "Charlie"]}).map do |user|
  user["_id"]
end

10.times do
  post = {
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.sentence,
    user_id: author_ids.sample
  }
  posts.insert(post)
end

post_ids = posts.find.map { |post| post["_id"] }

10.times do
  comment = {
    content: Faker::Lorem.sentence,
    user_id: commenter_ids.sample,
    post_id: post_ids.sample
  }
  comments.insert(comment)
end

alice_id   = users.find_one(name: "Alice")["_id"]
bob_id     = users.find_one(name: "Bob")["_id"]
charlie_id = users.find_one(name: "Charlie")["_id"]

alice_posts = posts.find(user_id: alice_id).to_a

alice_comments = comments.find(user_id: alice_id).to_a

bob_posts = posts.find(user_id: bob_id).to_a

bob_post_ids = bob_posts.map { |p| p["_id"] }

comments_on_bob_posts = comments.find(post_id: {"$in" => bob_post_ids}).to_a
bob_posts_with_comments_ids = comments_on_bob_posts.map { |c| c["post_id"] }.uniq

bob_posts_with_comments = bob_posts.select do |p|
  bob_posts_with_comments_ids.include? p["_id"]
end

comments_on_bob_posts_by_alice = comments_on_bob_posts.select do |p|
  p["user_id"] == alice_id
end
bob_posts_with_comments_by_alice_ids = comments_on_bob_posts_by_alice.map { |c| c["post_id"] }.uniq

comments_on_bob_posts_by_charlie = comments_on_bob_posts.select do |p|
  p["user_id"] == charlie_id
end
bob_posts_with_comments_by_charlie_ids = comments_on_bob_posts_by_charlie.map { |c| c["post_id"] }.uniq

bob_posts_with_comments_by_alice_or_charlie_ids = (bob_posts_with_comments_by_alice_ids +
bob_posts_with_comments_by_charlie_ids).uniq

bob_posts_with_comments_by_alice = bob_posts.select do |p|
  bob_posts_with_comments_by_alice_ids.include? p["_id"]
end

bob_posts_with_comments_by_alice_or_charlie = bob_posts.select do |p|
  bob_posts_with_comments_by_alice_or_charlie_ids.include? p["_id"]
end

################

db       = client.db("demo_blog_app_2");
users    = db["users"];
posts    = db["posts"];

users.drop
posts.drop

alice = {
  name: "Alice",
  age: 25,
  address: "1 Main Street, London",
  hobbies: ["sailing", "walking"]
}

bob = {
  name: "Bob",
  age: 46,
  address: "2 Main Street, London",
  children: [
    {name:"Foo", age:10},
    {name:"Bar", age:8},
    {name:"Baz", age:5}
  ]
}

charlie = {
  name: "Charlie",
  age: 31,
  children: [
    {name:"Foo", age:5, hobbies: ["painting"]}
  ]
}

users.insert([alice, bob, charlie])

author_ids = users.find(name: {"$in" => ["Alice", "Bob"]}).map do |user|
  user["_id"]
end

commenter_ids = users.find(name: {"$in" => ["Alice", "Bob", "Charlie"]}).map do |user|
  user["_id"]
end


# initial setup
10.times do

  comments = []
  rand(0..5).times do
    comment = {
      content: Faker::Lorem.sentence,
      user_id: commenter_ids.sample,
    }
    comments << comment
  end

  post = {
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.sentence,
    user_id: author_ids.sample,
  }
  post[:comments] = comments unless comments.empty?
  posts.insert(post)
end


alice_id   = users.find_one(name: "Alice")["_id"]
bob_id     = users.find_one(name: "Bob")["_id"]
charlie_id = users.find_one(name: "Charlie")["_id"]

alice_posts = posts.find(user_id: alice_id).to_a

#find all comments by Alice
posts_with_comments_by_alice = posts.find(
  {'comments.user_id' => alice_id},
  fields: ["comments"]
).to_a
comments_by_alice = posts_with_comments_by_alice.map do |p|
  p["comments"].select do |c|
    c["user_id"] == alice_id
  end
end.flatten

bob_posts = posts.find(user_id: bob_id).to_a

bob_posts_with_comments = posts.find(user_id: bob_id, comments: {"$exists" => true}).to_a

bob_posts_with_comments_by_alice = posts.find(
  :user_id => bob_id,
  'comments.user_id' => alice_id
).to_a

bob_posts_with_comments_by_alice_or_charlie = posts.find(
  :user_id => bob_id,
  'comments.user_id' => {"$in" => [alice_id, charlie_id]}
).to_a
