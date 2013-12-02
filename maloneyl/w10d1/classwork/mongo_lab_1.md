#reference a collection
db.collection_names
users = db.collection "users"
users = db["users"]

#insert a new record
gary = {name: "Gary", age: 25}
users.insert gary

#insert lots of records
require 'faker'
Faker::Name.first_name
10.times { users.insert(name: Faker::Name.first_name, age: rand(1..100)) }

#find all records (note: cursor returned)
users.find

#grab the first record (note: hash returned)
users.find.first
users.find.first.class
users.find.first.class.ancestors

#grab the first matching criteria
users.find(name: 'Bob').first
users.find_one(name: 'Bob')

#limit returned fields
users.find({name: 'Bob'}, fields: ["name", "age"]).first
users.find({name: 'Bob'}, fields: {"name" => true, "age" => true, "_id" => false}).first

#itterate through a cursor
users.find.each { |u| puts u["name"] }
users.find.map { |u| u["name"] }

#or fetch all and convert to array
users.find({}, fields: ["name"]).to_a

#mongo can sort the results for us
users.find({}, fields: ["name", "age"]).sort("age").to_a

#update a record
alice = users.find_one({name: "Alice"})
alice["status"] = "married"
users.update({name: "Alice"}, alice)
alice = users.find_one({name: "Alice"})

#update multiple records matching criteria
users.update(
  {age: {"$gt" => 30}},
  {"$set" => {overThirty: true}},
  {multi: true}
)
users.find(overThirty: true).count

#upsert a record
2.times {
  users.update(
    {name: "upserted"},
    {"$inc" => {age: 1}},
    {upsert: true}
  )
}
users.find_one(name: "upserted")

#remove a record
users.find(name: "Gary").count
users.remove(name: "gary")
users.find(name: "Gary").count

#add a collection
posts = db["posts"]
posts.count
db.collection_names
posts.insert(title: "first")
posts.count
db.collection_names

#drop a collection
posts.drop
posts.count
db.collection_names

#add a new db
db2 = client.db("gallery_app")
galleries = db2["galleries"]
galleries.insert(name: "Jon's Gallery")

#drop a db
client.drop_database("gallery_app")


LAB: practice mongo CRUD via ruby driver
-----------------------------------------

Perform the following steps in the console and record the ruby you use for each step:

A) Normalized Schema

1. add a "posts" collection and a "comments" collection to "demo_blog_app"
``````
client = Mongo::MongoClient.new('localhost', 27017)
db = client.db("demo_blog_app")
posts = db["posts"]
comments = db["comments"]
[57] pry(main)> comments.insert(content: "first comment")
=> BSON::ObjectId('529c9d9e84e1b6496c00000e')
[58] pry(main)> db.collection_names
=> ["system.indexes", "users", "posts", "comments"]
``````

2. add 10 sample documents (posts) with:
* "title" and "content" fields filled with lorem ipsum (use Faker)
* and a "user_id" field set to Alice or Bob's _id
```````
[24] pry(main)> user_ids = users.find({:name => {"$in" => ["Alice", "Bob"]}}, :fields => "_id").map { |user| user["_id"] }
=> [BSON::ObjectId('529c692422139c0bd5decbe2'),
 BSON::ObjectId('529c696322139c0bd5decbe3')]
[25] pry(main)> 10.times{ posts.insert(
[25] pry(main)*     title: Faker::Lorem.sentence,
[25] pry(main)*     content: Faker::Lorem.paragraph,
[25] pry(main)*     user_id: user_ids.sample
[25] pry(main)* ) }
=> 10
```````

3. add 10 sample comments with:
* a "content" field filled with lorem ipsum (use Faker)
* a "user_id" field set to Alice, Bob or Charlie's _id
* and a "post_id" field set to one of the existing posts' _id values
``````
[26] pry(main)> user_ids = users.find({:name => {"$in" => ["Alice", "Bob", "Charlie"]}}, :fields => "_id").map { |user| user["_id"] }
=> [BSON::ObjectId('529c692422139c0bd5decbe2'),
 BSON::ObjectId('529c696322139c0bd5decbe3'),
 BSON::ObjectId('529c696322139c0bd5decbe4')]
[27] pry(main)> comments = db["comments"]
=> #<Mongo::Collection:0x007ff7491cd430 ...
[30] pry(main)> post_ids = posts.find({}, :fields => "_id").map { |post| post["_id"] }
=> [BSON::ObjectId('529c99a384e1b6496c00000c'),
 BSON::ObjectId('529cee5484e1b6629c000001'),
 BSON::ObjectId('529cee5484e1b6629c000002'),
 BSON::ObjectId('529cee5484e1b6629c000003'),
 BSON::ObjectId('529cee5484e1b6629c000004'),
 BSON::ObjectId('529cee5484e1b6629c000005'),
 BSON::ObjectId('529cee5484e1b6629c000006'),
 BSON::ObjectId('529cee5484e1b6629c000007'),
 BSON::ObjectId('529cee5484e1b6629c000008'),
 BSON::ObjectId('529cee5484e1b6629c000009'),
 BSON::ObjectId('529cee5484e1b6629c00000a')]
[31] pry(main)> 10.times{ comments.insert(
[31] pry(main)*     content: Faker::Lorem.paragraph,
[31] pry(main)*     user_id: user_ids.sample,
[31] pry(main)*     post_id: post_ids.sample
[31] pry(main)* )}
=> 10
``````

4. find all posts by Alice
``````
[33] pry(main)> alice_id = users.find({:name => "Alice"}, :fields => "_id").first
=> {"_id"=>BSON::ObjectId('529c692422139c0bd5decbe2')}
[49] pry(main)> alice_id = users.find({:name => "Alice"}, :fields => "_id").first["_id"]
=> BSON::ObjectId('529c692422139c0bd5decbe2')
[57] pry(main)> posts.find({:user_id => alice_id}).each { |p, i| puts "#{i}. #{p["title"]}" }
. In atque omnis rerum.
. Asperiores nam velit doloribus culpa nostrum et doloremque.
. Delectus aut hic architecto rem provident facere labore similique.
. Reprehenderit nostrum et quia illum omnis magni quam voluptas.
. Pariatur perspiciatis consequatur consequuntur et autem velit.
=> nil
``````

5. find all comments by Alice
```````
[60] pry(main)> comments.find({:user_id => alice_id}).each { |c, i| puts "#{i}. #{c["content"]}" }
. Ab soluta id delectus quos magnam. Error ea non. Molestiae necessitatibus eius adipisci quod.
. Sed iusto nam cumque sapiente modi voluptatem. Et aliquid cum tempore. Quia recusandae dolor et quam dolore sapiente qui. Aut aut sequi recusandae et. Quo facilis nesciunt fugit repudiandae.
. Vitae laborum dicta dignissimos. Quos pariatur velit eligendi voluptas. Rerum quia aliquid eum fugiat.
. Maxime laboriosam voluptates labore molestias qui earum. Dolorem tempora esse labore velit dolor nostrum. Corrupti quisquam expedita qui ipsa cumque molestias laboriosam. Aut doloribus consectetur animi.
. Molestias quo dolorum. Aut ab exercitationem sit enim magnam sed sunt. Doloremque veritatis minus vel officia aliquid quos est.
=> nil
```````

6. find all posts by Bob that have at least one comment
```````
[63] pry(main)> bob_id = users.find({:name => "Bob"}, :fields => "_id").first["_id"]
=> BSON::ObjectId('529c696322139c0bd5decbe3')
[71] pry(main)> bob_posts_ids = posts.find({:user_id => bob_id}, :fields => "_id").map { |p| p["_id"] }
=> [BSON::ObjectId('529cee5484e1b6629c000001'),
 BSON::ObjectId('529cee5484e1b6629c000004'),
 BSON::ObjectId('529cee5484e1b6629c000005'),
 BSON::ObjectId('529cee5484e1b6629c000006'),
 BSON::ObjectId('529cee5484e1b6629c000007')]
[72] pry(main)> comments.find({:post_id => {"$in" => bob_posts_ids}}).each { |c, i| puts "#{i}. #{c["content"]}" }
. Vitae laborum dicta dignissimos. Quos pariatur velit eligendi voluptas. Rerum quia aliquid eum fugiat.
. Ut suscipit architecto. Eveniet perferendis dolor. Et nulla cum consequatur.
. Repellat deleniti officiis quo pariatur. Deserunt voluptatibus facilis non odit mollitia. Occaecati esse natus provident. Temporibus veniam et. Possimus excepturi rerum eaque ut.
. Autem sint quasi incidunt at ea. Illo iure neque eveniet veritatis vel. Amet aut alias. Voluptas accusantium expedita sunt quia omnis eveniet.
=> nil
```````

7. find all posts by Bob that Alice has commented on
````````
[73] pry(main)> comments.find({:post_id => {"$in" => bob_posts_ids}, :user_id => alice_id}).each { |c, i| puts "#{i}. #{c["post_id"]}" }
. 529cee5484e1b6629c000004
=> nil
````````

8. find all posts by Bob that Alice or Charlie has commented on
````````
[78] pry(main)> charlie_id = users.find({:name => "Charlie"}, :fields => "_id").first["_id"]
=> BSON::ObjectId('529c696322139c0bd5decbe4')
[79] pry(main)> comments.find({:post_id => {"$in" => bob_posts_ids}, :user_id => {"$in" => [alice_id, charlie_id]}}).each { |c, i| puts "#{i}. #{c["post_id"]}" }
. 529cee5484e1b6629c000004
. 529cee5484e1b6629c000006
. 529cee5484e1b6629c000005
=> nil
````````

B) Denormalized Schema

1. add a "posts" collection to a new db: "demo_blog_app_2"
`````
[80] pry(main)> db2 = client.db("demo_blog_app_2")
=> #<Mongo::DB:0x007ff74aecbd48
 @acceptable_latency=15, ...
[81] pry(main)> posts = db2["posts"]
=> #<Mongo::Collection:0x007ff74af11410
 @acceptable_latency=15, ...
[82] pry(main)> posts.insert(:title => "First post in new DB")
=> BSON::ObjectId('529cf97784e1b6629c000015')
[83] pry(main)> db2.collection_names
=> ["system.indexes", "posts"]
`````

2. add 10 sample documents with:
* "title" and "content" fields filled with lorem ipsum
* a "user_id" field set to Alice or Bob's _id
* a "comments" field that is an array containing a random number of embedded comments. Each of these should have:
  * a "content" field filled with lorem ipsum (use Faker)
  * and a "user_id" field set to Alice, Bob or Charlie's _id
```````
[95] pry(main)> 10.times{ posts.insert(
[95] pry(main)*     title: Faker::Lorem.sentence,
[95] pry(main)*     content: Faker::Lorem.paragraph,
[95] pry(main)*     user_id: [alice_id, bob_id].sample,
[95] pry(main)*     comments: rand(1..10).times.map do
[95] pry(main)*       {
[95] pry(main)*         :content => Faker::Lorem.paragraph,
[95] pry(main)*         :user_id => [alice_id, bob_id, charlie_id].sample
[95] pry(main)*       }
[95] pry(main)*     end
[95] pry(main)* )}
=> 10
```````

3. find all posts by Alice
```````
[96] pry(main)> posts.find({:user_id => alice_id}).each { |p, i| puts "#{i}. #{p["title"]}" }
. Facilis nulla nesciunt eum dicta nobis dolor ut.
. Aliquam voluptatibus deserunt et.
. Est cupiditate non sed et suscipit deserunt officia perspiciatis.
. Rem dolorem sapiente ut quia.
. Hic quo quaerat tenetur inventore.
. Sapiente esse ea asperiores delectus.
. Debitis qui sunt velit eius aut sit ut.
=> nil
```````

4. find all comments by Alice
``````
[104] pry(main)> posts.find({"comments.user_id" => alice_id}).count
=> 9
``````
Those are just posts with Alice's comments, but Alice has more comments than 9...


5. find all posts by Bob that have at least one comment (hint: $exists or $size operators might be handy)
``````
[116] pry(main)> posts.find({"user_id" => bob_id, "comments" => {"$exists" => true}}).each { |p, i| puts "#{i}. #{p["title"]}" }
. Praesentium voluptatem aut distinctio aliquid inventore quasi doloremque eligendi.
. Rem quaerat nesciunt nisi eum voluptas et veniam maiores.
. Corporis nemo sequi consequatur pariatur repudiandae.
. Sapiente est rerum beatae dolorem mollitia.
. Non sed aut asperiores iste cum vel.
. Atque impedit accusantium temporibus quis dolor est.
. Ex voluptas dolore voluptas et et.
. Mollitia tenetur quam laudantium.
. Voluptatem minima sed labore recusandae veritatis nesciunt sapiente aut.
. Repudiandae nisi architecto minima accusantium ut.
. Ut aliquid ipsa dolorem magnam laborum.
. Doloremque aut veniam error expedita cum voluptas vel maxime.
. Est exercitationem vel nostrum sed nisi.
=> nil
``````

6. find all posts by Bob that Alice has commented on
`````
[117] pry(main)> posts.find({"user_id" => bob_id, "comments.user_id" => alice_id}).each { |p, i| puts "#{i}. #{p["title"]}" }
. Repudiandae nisi architecto minima accusantium ut.
. Ut aliquid ipsa dolorem magnam laborum.
. Doloremque aut veniam error expedita cum voluptas vel maxime.
. Est exercitationem vel nostrum sed nisi.
=> nil
`````

7. find all posts by Bob that Alice or Charlie has commented on
`````
[121] pry(main)> posts.find({"user_id" => bob_id, "comments.user_id" => {"$in" => [alice_id, charlie_id]}}).each{ |p, i| puts "#{i}. #{p["title"]}" }
. Voluptatem minima sed labore recusandae veritatis nesciunt sapiente aut.
. Repudiandae nisi architecto minima accusantium ut.
. Ut aliquid ipsa dolorem magnam laborum.
. Doloremque aut veniam error expedita cum voluptas vel maxime.
. Est exercitationem vel nostrum sed nisi.
=> nil
`````
