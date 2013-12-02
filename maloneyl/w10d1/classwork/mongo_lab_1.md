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
[63] pry(main)> users.find(name: "Alice").first
=> {"_id"=>BSON::ObjectId('529c692422139c0bd5decbe2'), ...
[64] pry(main)> users.find(name: "Bob").first
=> {"_id"=>BSON::ObjectId('529c696322139c0bd5decbe3'), ...
[65] pry(main)> 10.times{ posts.insert(
  title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph,
  user_id: ['529c692422139c0bd5decbe2', '529c696322139c0bd5decbe3'].sample
  ) }
=> 10
```````

3. add 10 sample comments with:
* a "content" field filled with lorem ipsum (use Faker)
* a "user_id" field set to Alice, Bob or Charlie's _id
* and a "post_id" field set to one of the existing posts' _id values
``````
[67] pry(main)> users.find_one(name: "Charlie")
=> {"_id"=>BSON::ObjectId('529c696322139c0bd5decbe4'), ...
10.times{ comments.insert(
  content: Faker::Lorem.paragraph,
  user_id: ['529c692422139c0bd5decbe2', '529c696322139c0bd5decbe3', '529c696322139c0bd5decbe4'].sample,
  post_id: ['529c9f0184e1b6496c00000f', '529c9f0184e1b6496c000010', '529c9f0184e1b6496c000011', '529c9f0184e1b6496c000012', '529c9f0184e1b6496c000013', '529c9f0184e1b6496c000014', '529c9f0184e1b6496c000015', '529c9f0184e1b6496c000016', '529c9f0184e1b6496c000017', '529c9f0184e1b6496c000018'].sample
)}
10.times{ comments.insert(
  content: Faker::Lorem.paragraph,
  user_id: ['529c692422139c0bd5decbe2', '529c696322139c0bd5decbe3', '529c696322139c0bd5decbe4'].sample,
  post_id: [posts.find.map { |p| p["_id"] }].sample
)}
``````

4. find all posts by Alice
``````
[84] pry(main)> posts.find(user_id: "529c692422139c0bd5decbe2").each { |p| puts p["title"] }
Molestiae nihil quae maiores possimus rem illum fuga impedit.
Sint blanditiis numquam aut ut error adipisci minima.
=> nil
[85] pry(main)> posts.find(user_id: "529c692422139c0bd5decbe2").count
=> 2
``````

5. find all comments by Alice
```````
[88] pry(main)> comments.find(user_id: "529c692422139c0bd5decbe2").each { |c| puts c["content"] }
Dolores dolores qui provident voluptas sed quia. Saepe nostrum quia quibusdam dolorem labore in. Ipsam inventore possimus. Sed dolor est occaecati veniam eum.
Numquam illum excepturi incidunt rem quia sunt. Impedit ut labore harum. Delectus eligendi suscipit fuga dolorum quia ullam. Tenetur facere ut assumenda natus. Et tenetur voluptatem quidem est quia in.
Pariatur molestiae aut dolores sed non. Doloremque repellendus eius id a dignissimos. Voluptatem quo ratione et quis atque dolores.
Iure quia animi ullam doloribus nisi ut autem. Dolor odit nam aut perferendis. Aperiam laborum quae. Autem eius consequatur voluptatibus ut omnis. Tempora dolores consequatur tenetur cupiditate.
=> nil
[89] pry(main)> comments.find(user_id: "529c692422139c0bd5decbe2").count
=> 4
```````

6. find all posts by Bob that have at least one comment
```````
[104] pry(main)> posts.find(user_id: '529c696322139c0bd5decbe3').each { |p| bob_posts << p["_id"] }
=> nil
[105] pry(main)> bob_posts
=> [BSON::ObjectId('529c9f0184e1b6496c00000f'), ...]
[108] pry(main)> bob_posts.count
=> 16
[112] pry(main)> bob_posts.each do
[112] pry(main)*   |bob_post| comments.find(post_id: bob_post)
[112] pry(main)* end
=> [BSON::ObjectId('529c9f0184e1b6496c00000f'),
 BSON::ObjectId('529c9f0184e1b6496c000010'),
 BSON::ObjectId('529c9f0184e1b6496c000011'),
 BSON::ObjectId('529c9f0184e1b6496c000012'),
 BSON::ObjectId('529c9f0184e1b6496c000013'),
 BSON::ObjectId('529c9f0184e1b6496c000014'),
 BSON::ObjectId('529c9f0184e1b6496c000015'),
 BSON::ObjectId('529c9f0184e1b6496c000016'),
 BSON::ObjectId('529c9f0184e1b6496c00000f'),
 BSON::ObjectId('529c9f0184e1b6496c000010'),
 BSON::ObjectId('529c9f0184e1b6496c000011'),
 BSON::ObjectId('529c9f0184e1b6496c000012'),
 BSON::ObjectId('529c9f0184e1b6496c000013'),
 BSON::ObjectId('529c9f0184e1b6496c000014'),
 BSON::ObjectId('529c9f0184e1b6496c000015'),
 BSON::ObjectId('529c9f0184e1b6496c000016')]
```````

7. find all posts by Bob that Alice has commented on
8. find all posts by Bob that Alice or Charlie has commented on

B) Denormalized Schema

1. add a "posts" collection to a new db: "demo_blog_app_2"
2. add 10 sample documents with:
* "title" and "content" fields filled with lorem ipsum
* a "user_id" field set to Alice or Bob's _id
* a "comments" field that is an array containing a random number of embedded comments. Each of these should have:
* a "content" field filled with lorem ipsum (use Faker)
* and a "user_id" field set to Alice, Bob or Charlie's _id
3. find all posts by Alice
4. find all comments by Alice
5. find all posts by Bob that have at least one comment (hint: $exists or $size operators might be handy)
6. find all posts by Bob that Alice has commented on
7. find all posts by Bob that Alice or Charlie has commented on
