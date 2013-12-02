QUESTIONS AND COMMENTS AFTER HOMEWORK/LAB
==========================================

* I think I prefer relational databases a lot more...
* Haven't figured out how to find all comments by Alice in the denormalized version, i.e. without a comments collection.


CLASS NOTES
===========

1. MONGODB
-----------------------

a NoSQL DB, i.e. not a relational DB
from "humongous" -- good for big data

NoSQL has its own query language, but the most defining factor is that it doesn't perform "join" operations
example of join:
Post.joins(:comments).merge(Comment.joins(:users).where('users.email' => 'abc@email.com'))

normalizing data = drying up our data, i.e. no duplicate data in separate tables (e.g. how we've been building our blogs, where for our comments table we only get the user_id instead of duplicating more info from the users table like email or whatever)

but if we denormalize data and do repeat certain fields, it's better performance because we can speed up queries (e.g. perform one less join). but that could mean that the info would later become inconsistent, e.g. the user tables' email is changed, while the comments one isn't

denormalizing means embedding redundant data (e.g. posts have comments embedded, which in turn embed some user info)
a denormalized blog might have a schema like this for its posts:
- title
- content
- comments (inline as a big record; an array with hashes of content, user_id, email)
then we'll be performing a single query like comments.email

join operations are very slow and memory-intensive, but with datasets larger and larger, it's not practical to scale relational databases
scaling vertically = buying a bigger server with a faster processor and more RAM, continuing to rely on joins = $$$, not possible for many companies
scaling horizontally = buying lots of regular servers (nodes) and using them together as a cluster (distributed database) = no joins

when moving to a distributed DB, we split our data across all the nodes in the clusters, e.g. by the value of a field or key, known as sharding
e.g. using the name field as a shard-key, so names A-C are on node-0, names D-F on node-1, etc.
if we then need to find a user of a certain age, that task is split among all these nodes (i.e. every node just deals with one-Xth of the data), so it's still better performance

Mongo has the sharding logic built into the server
prior to the move to NoSQL, it's common to manually set up sharding with a relationship database

replication
makes sure our database is resilient to hardware failure
a master node handles all writes, while slave nodes (which are mostly in sync with all master data) only handle reads
failover = i.e. can fail gracefully and recover data
if the master fails, then slave-1 becomes the new master while slave-2 still does what it does

CAP theorem
a distributed system can only have two of the following three:
- consistency -- all nodes agree on the current state of the dataset
- availability -- all nodes respond in a timely fashion
- partition tolerance -- the system can continue to function if a node goes down

all databases aim to offer partition tolerance, so then the choice comes down to consistency or availability

relational databases favor consistency by offering ACID properties:
- atomicity -- can roll back if anything goes wrong; all-or-nothing transactions
- consistency -- all records agree (e.g. post with id 1 must exist if comment with post_id=1 exists)
- isolation -- parallel transitions give the same result as serial ones
- durability -- data must be persisted before the transaction ends
can be slow and hence the DB can become unavailable

NoSQL databases do the other trade-off: favor availability over consistency by offering BASE properties:
- basically available -- most nodes will respond in a timely manner
- soft state -- dataset might be inconsistent at times
- eventual consistency -- given enough time, all nodes will agree

the case for NoSQL
- huge dataset and no supercomputers
- app needs to respond quickly to read/write requests
- app doesn't rely on complex associations
- ok for app to return different results to different users (soft state and eventual consistency)
typical use cases:
- social media
- large eCommerce systems, e.g. Amazon DynamoDB
- search engines, e.g. Google BigData DB
- large-scale analytics, e.g. scientific data, server logs (via Map/Reduce)

the case for relational DB:
- dataset will be small in the foreseeable future
- need to leverage complex associations between records
- transactions MUST be consistent
typical use cases:
- small data site
- financial transactions e.g. payment handling
- ad-hoc analytics by non-programmers, e.g. business intelligence via SQL

MongoDB:
- founded in 2007 by former DoubleClick CTO/CEO
- open-sourced in 2009
- one of the most popular NoSQL DBs, used by Cisco, eBay, Salesforce, SAP, Telefonica
- excellent documentations
- large user base
- tools familiar to relational DBs, e.g. console, expressive querying language
- easy NoSQL features: auto-sharding and replication

brew install mongodb
after install: hash -rf
mongo to go to console

show dbs (show databases)



BUILD A BLOG!

create new db:
> use demo_blog_app
switched to db demo_blog_app

show current db:
> db
demo_blog_app

mongo uses javascript!
so the below is just like creating a js object (the … is automatic when you press enter)
> alice = {
... name: "Alice",
... age: 25,
... address: "1 Main Street, London",
... hobbies: ["sailing", "walking"]
... }
{
  "name" : "Alice",
  "age" : 25,
  "address" : "1 Main Street, London",
  "hobbies" : [
    "sailing",
    "walking"
  ]
}
>

these objects can have any structure you want
i.e. each person can have any 'fields' -- there's no restrictions

> bob = {
... name: "Bob",
... age: 26,
... address: "2 Main Street, London",
... children: [
... {name: "Foo", age: 10},
... {name: "Bar", age: 8},
... {name: "Baz", age: 5}
... ]
... }
{
  "name" : "Bob",
  "age" : 26,
  "address" : "2 Main Street, London",
  "children" : [
    {
      "name" : "Foo",
      "age" : 10
    },
    {
      "name" : "Bar",
      "age" : 8
    },
    {
      "name" : "Baz",
      "age" : 5
    }
  ]
}

> charlie = {
...   name: "Charlie",
...   age: 31,
...   children: [
...     {name:"Foo", age:5, hobbies: ["painting"]}
...   ]
... }
{
  "name" : "Charlie",
  "age" : 31,
  "children" : [
    {
      "name" : "Foo",
      "age" : 5,
      "hobbies" : [
        "painting"
      ]
    }
  ]
}

> db.users.insert(alice) # insert the alice object into the users collection of the current db
> show collections
system.indexes # automatically created
users # our collection created
> db.users.insert([bob, charlie]) # add more than one object at a time with an array
> db.users.find()
{ "_id" : ObjectId("529c692422139c0bd5decbe2"), "name" : "Alice", "age" : 25, "address" : "1 Main Street, London", "hobbies" : [  "sailing",  "walking" ] }
{ "_id" : ObjectId("529c696322139c0bd5decbe3"), "name" : "Bob", "age" : 26, "address" : "2 Main Street, London", "children" : [   {   "name" : "Foo",   "age" : 10 },   {   "name" : "Bar",   "age" : 8 },  {   "name" : "Baz",   "age" : 5 } ] }
{ "_id" : ObjectId("529c696322139c0bd5decbe4"), "name" : "Charlie", "age" : 31, "children" : [  {  "name" : "Foo",  "age" : 5,  "hobbies" : [  "painting" ] } ] }
> db.users.find().pretty() # pretty print!
{
  "_id" : ObjectId("529c692422139c0bd5decbe2"),
  "name" : "Alice",
  "age" : 25,
  "address" : "1 Main Street, London",
  "hobbies" : [
    "sailing",
    "walking"
  ]
}
{
  "_id" : ObjectId("529c696322139c0bd5decbe3"),
 etc. etc.
}

"_id" is javascript convention: prefix immutable fields with underscore (i.e. these are not fields meant to be changed manually)
the ID is a long alphanumeric, guaranteed that you'll never get collisions among nodes (i.e. good for distributed DB)
the first portion of the ID is based on our Mac address, next portion related to the time
you might want to get a gem for that first portion and change it to some uniq ID instead though

> db.users.find({name: "Alice"}) # function with js object passed as argument
{ "_id" : ObjectId("529c692422139c0bd5decbe2"), "name" : "Alice", "age" : 25, "address" : "1 Main Street, London", "hobbies" : [  "sailing",  "walking" ] }
> db.users.find({age: 26})
{ "_id" : ObjectId("529c696322139c0bd5decbe3"), "name" : "Bob", "age" : 26, "address" : "2 Main Street, London", "children" : [   {   "name" : "Foo",   "age" : 10 },   {   "name" : "Bar",   "age" : 8 },  {   "name" : "Baz",   "age" : 5 } ] }
if there are more than one entries that match the search term, they'll just all show up

> db.users.find({age: 26}, {name: true}) # specify what we want returned in lieu of the full object (id is always returned by default)
{ "_id" : ObjectId("529c696322139c0bd5decbe3"), "name" : "Bob" }
> db.users.find({age: 26}, {name: true, address: true, _id: false})
{ "name" : "Bob", "address" : "2 Main Street, London" }

> db.users.find({age: {$gte: 20} }) # $gte = greater than or equal to; $ is a query operator
{ "_id" : … }

> db.users.find({age: {$gt: 25} }) # greater than
> db.users.find({age: {$lte: 25} }) # less than or equal to

> db.users.find({ name: {$in: ["Alice", "Bob", "Xavier"]} }) # any records where the name is any of those in the array

for more query operators:
http://docs.mongodb.org/manual/reference/operator/query/

> db.users.find({children: {name: "Foo"} }) # returns nothing even though Bob and Charlie have a kid named Foo. why? because mongo is looking for that exact children object, and there is none
> db.users.find({children: {name: "Foo", age: 5, hobbies: ["painting"]} }) # now this works, because we're passing the complete object
{ "_id" : ObjectId("529c696322139c0bd5decbe4"), "name" : "Charlie", "age" : 31, "children" : [  {  "name" : "Foo",  "age" : 5,  "hobbies" : [  "painting" ] } ] }
but of course, we CAN only search by name, like this:
> db.users.find({"children.name": "Foo"})
{ "_id" : ObjectId("529c696322139c0bd5decbe3"), "name" : "Bob", "age" : 26, "address" : "2 Main Street, London", "children" : [   {   "name" : "Foo",   "age" : 10 },   {   "name" : "Bar",   "age" : 8 },  {   "name" : "Baz",   "age" : 5 } ] }
{ "_id" : ObjectId("529c696322139c0bd5decbe4"), "name" : "Charlie", "age" : 31, "children" : [  {  "name" : "Foo",  "age" : 5,  "hobbies" : [  "painting" ] } ] }
> db.users.find({"children.0.name": "Foo"}) # this specifies the 0th one in children

> db.users.find({"children.name": "Foo", "children.age": 5}) # !! find a child with the name Foo and find a child with the age 5, BUT not both in a single child/record
{ "_id" : ObjectId("529c696322139c0bd5decbe3"), "name" : "Bob", "age" : 26, "address" : "2 Main Street, London", "children" : [   {   "name" : "Foo",   "age" : 10 },   {   "name" : "Bar",   "age" : 8 },  {   "name" : "Baz",   "age" : 5 } ] }
{ "_id" : ObjectId("529c696322139c0bd5decbe4"), "name" : "Charlie", "age" : 31, "children" : [  {  "name" : "Foo",  "age" : 5,  "hobbies" : [  "painting" ] } ] }
to specify that the conditions must be in a single record:
> db.users.find({children: { $elemMatch: {name: "Foo", age: 5} } })
{ "_id" : ObjectId("529c696322139c0bd5decbe4"), "name" : "Charlie", "age" : 31, "children" : [  {  "name" : "Foo",  "age" : 5,  "hobbies" : [  "painting" ] } ] }

> db.users.insert({name: "Delete Me"})
> db.users.find({name: "Delete Me"})
{ "_id" : ObjectId("529c6fb422139c0bd5decbe5"), "name" : "Delete Me" }
> db.users.remove({name: "Delete Me"}, {justOne: true})
> db.users.find({name: "Delete Me"}) # returns nothing now

> eve = {
... name: "Eve",
... age: 45,
... hobbies: ["flying"],
... status: "single"
... }
{
  "name" : "Eve",
  "age" : 45,
  "hobbies" : [
    "flying"
  ],
  "status" : "single"
}
> db.users.insert(eve)
> eve = db.users.findOne({name: "Eve"})
{
  "_id" : ObjectId("529c706b22139c0bd5decbe6"),
  "name" : "Eve",
  "age" : 45,
  "hobbies" : [
    "flying"
  ],
  "status" : "single"
}
> eve.status = "married"
married
> eve.spouse = {name: "WALL-E"} # yes, we can .something that doesn't exist yet
{ "name" : "WALL-E" }
> eve
{
  "_id" : ObjectId("529c706b22139c0bd5decbe6"),
  "name" : "Eve",
  "age" : 45,
  "hobbies" : [
    "flying"
  ],
  "status" : "married",
  "spouse" : {
    "name" : "WALL-E"
  }
}
> db.users.update({_id: eve._id}, eve) # 1st arg: the id/how to grab that record, # 2nd arg: the object to update as
> db.users.find({_id: eve._id}).pretty()
{
  "_id" : ObjectId("529c706b22139c0bd5decbe6"),
  "name" : "Eve",
  "age" : 45,
  "hobbies" : [
    "flying"
  ],
  "status" : "married",
  "spouse" : {
    "name" : "WALL-E"
  }
}

> db.users.update({_id: eve._id}, {$inc: {age: 1}} ) # $inc: {age: 1} = increment age by 1
> db.users.find({_id: eve._id}).pretty()
{
  "_id" : ObjectId("529c706b22139c0bd5decbe6"),
  "name" : "Eve",
  "age" : 46,
  "hobbies" : [
    "flying"
  ],
  "status" : "married",
  "spouse" : {
    "name" : "WALL-E"
  }
}
> db.users.update({_id: eve._id}, {$inc: {age: 1}} )
> db.users.find({_id: eve._id}).pretty()
{
  "_id" : ObjectId("529c706b22139c0bd5decbe6"),
  "name" : "Eve",
  "age" : 47,
  "hobbies" : [
    "flying"
  ],
  "status" : "married",
  "spouse" : {
    "name" : "WALL-E"
  }
}

> db.users.update({name: "Eve"}, {
... $inc: {age: -1}, # that's decrement by 1
... $set: {"spouse.job": "garbage collection"}, # add
... $push: {hobbies: "shooting"} # push: for array; opposite is pop
... }
... )
> db.users.find({_id: eve._id}).pretty()
{
  "_id" : ObjectId("529c706b22139c0bd5decbe6"),
  "age" : 46,
  "hobbies" : [
    "flying",
    "shooting"
  ],
  "name" : "Eve",
  "spouse" : {
    "job" : "garbage collection",
    "name" : "WALL-E"
  },
  "status" : "married"
}

for more update query operators:
http://docs.mongodb.org/manual/reference/operator/update/

> db.users.find({status: {$exists: false} }) # find all records that do not have a status field
{ "_id" : ObjectId("529c692422139c0bd5decbe2"), "name" : "Alice", "age" : 25, "address" : "1 Main Street, London", "hobbies" : [  "sailing",  "walking" ] }
{ "_id" : ObjectId("529c696322139c0bd5decbe3"), "name" : "Bob", "age" : 26, "address" : "2 Main Street, London", "children" : [   {   "name" : "Foo",   "age" : 10 },   {   "name" : "Bar",   "age" : 8 },  {   "name" : "Baz",   "age" : 5 } ] }
{ "_id" : ObjectId("529c696322139c0bd5decbe4"), "name" : "Charlie", "age" : 31, "children" : [  {  "name" : "Foo",  "age" : 5,  "hobbies" : [  "painting" ] } ] }

> db.users.update({status: {$exists: false} }, { # find all records that do not have a status field
... $set: {status: "single"} # then set the status field to single
... }
... )
> db.users.count({status: {$exists: true} })
2 # because update only updates the FIRST record by default; unlike remove that would remove all by default
> db.users.update( {status: {$exists: false}}, {$set: {status: "single"}}, {multi: true} )

> db.users.update(
... {name: "Fred"},
... {$inc: {age: 1}},
... {upsert: true} # create this record if no record with the name Fred is found
... )
> db.users.find({name: "Fred"})
{ "_id" : ObjectId("529c75d28edf58d6880a8320"), "age" : 1, "name" : "Fred" } # age is set to 1 because there's nothing to increment from
> db.users.update( {name: "Fred"}, {$inc: {age: 1}}, {upsert: true} )
> db.users.find({name: "Fred"})
{ "_id" : ObjectId("529c75d28edf58d6880a8320"), "age" : 2, "name" : "Fred" }


> db.users.update(
... {name: "Bob"},
... {$push: {"children.2.hobbies": "singing"}} # get index-2
... )
> db.users.find({name: "Bob"}).pretty()
{
  "_id" : ObjectId("529c696322139c0bd5decbe3"),
  "address" : "2 Main Street, London",
  "age" : 26,
  "children" : [
    {
      "name" : "Foo",
      "age" : 10
    },
    {
      "name" : "Bar",
      "age" : 8
    },
    {
      "age" : 5,
      "hobbies" : [
        "singing"
      ],
      "name" : "Baz"
    }
  ],
  "name" : "Bob"
}

a better way:
> db.users.update(
... {name: "Bob", "children.name": "Baz"}, # specify more stuff in the query
... {$push: {"children.$.hobbies": "sunbathing"}} # $ is the positional operator; can be used one layer deep
... )
> db.users.find({name: "Bob"}).pretty()
{
  "_id" : ObjectId("529c696322139c0bd5decbe3"),
  "address" : "2 Main Street, London",
  "age" : 26,
  "children" : [
    {
      "name" : "Foo",
      "age" : 10
    },
    {
      "name" : "Bar",
      "age" : 8
    },
    {
      "age" : 5,
      "hobbies" : [
        "singing",
        "sunbathing"
      ],
      "name" : "Baz"
    }
  ],
  "name" : "Bob"
}


2. ROCKMONGO
------------------------

long installfest (see official notes)
http://localhost/rockmongo

****

then there's something for ruby too:

gem install mongo
gem install bson_ext

to use this ruby driver:

[1] pry(main)> require 'mongo'
=> true
[2] pry(main)> client = Mongo::MongoClient.new('localhost', 27017)
=> #<Mongo::MongoClient:0x007f849d820c98
 @acceptable_latency=15,
  …
[3] pry(main)> db = client.db("demo_blog_app")
=> #<Mongo::DB:0x007f849bb5ed30
 @acceptable_latency=15,
  …
[4] pry(main)> db.collection_names
=> ["system.indexes", "users"]
=> #<Mongo::Collection:0x007f849bd7ec00
 @acceptable_latency=15,
  …
[5] pry(main)> users = db.collection "users"
=> #<Mongo::Collection:0x007f849bd7ec00
 @acceptable_latency=15,
  …
[6] pry(main)> users = db["users"]; # alternative syntax for above; add ';' to suppress result
[7] pry(main)> gary = {name: "Gary", age: 25}
=> {:name=>"Gary", :age=>25}
[8] pry(main)> users.insert gary
=> BSON::ObjectId('529c937f84e1b6496c000001')

now we'll create a bunch of fake users:
[9] pry(main)> require 'faker'
=> true
[10] pry(main)> Faker::Name.first_name # generates random name
=> "Alford"
[11] pry(main)> Faker::Name.first_name # see? done testing...
=> "Gianni"
[13] pry(main)> 10.times{ users.insert(name: Faker::Name.first_name, age: rand(1..100)) }
=> 10

[14] pry(main)> users.find # there is no "find all" in mongo because typically mongo databases are giant
=> <Mongo::Cursor:0x3fc24ee010c8 namespace='demo_blog_app.users' @selector={} @cursor_id=>
[15] pry(main)> users.find.first
=> {"_id"=>BSON::ObjectId('529c696322139c0bd5decbe4'),
 "name"=>"Charlie",
 "age"=>31.0,
 "children"=>[{"name"=>"Foo", "age"=>5.0, "hobbies"=>["painting"]}]}
[16] pry(main)> users.find.first.class
=> BSON::OrderedHash
[17] pry(main)> users.find.first.class.ancestors
=> [BSON::OrderedHash,
 Hash,
 Enumerable,
 Object,
 PP::ObjectMixin,
 Kernel,
 BasicObject]
[18] pry(main)> users.find(name: "Bob").first
=> {"_id"=>BSON::ObjectId('529c696322139c0bd5decbe3'),
 "address"=>"2 Main Street, London",
 "age"=>26.0,
 "children"=>
  [{"name"=>"Foo", "age"=>10.0},
   {"name"=>"Bar", "age"=>8.0},
   {"age"=>5.0, "hobbies"=>["singing", "sunbathing"], "name"=>"Baz"}],
 "name"=>"Bob"}
[19] pry(main)> users.find_one(name: "Bob") # same as above
=> {"_id"=>BSON::ObjectId('529c696322139c0bd5decbe3'), ..
[20] pry(main)> users.find_one({name: "Bob"}, fields: ["name", "age"])
=> {"_id"=>BSON::ObjectId('529c696322139c0bd5decbe3'), "age"=>26.0, "name"=>"Bob"}
[21] pry(main)> users.find_one({name: "Bob"}, fields: {"age" => true, "name" => true, "_id" => false})
=> {"age"=>26.0, "name"=>"Bob"}
[22] pry(main)> users.find.each { |u| puts u["name"] }
Charlie
Eve
Alice
…
[23] pry(main)> users.find.map { |u| u["name"] }
=> ["Charlie",
 "Eve",
 "Alice",
 "Fred",
 "Bob",
 "Gary",
 …]
[24] pry(main)> users.find({}, fields: "name").to_a
=> [{"_id"=>BSON::ObjectId('529c696322139c0bd5decbe4'), "name"=>"Charlie"},
 {"_id"=>BSON::ObjectId('529c706b22139c0bd5decbe6'), "name"=>"Eve"},
 {"_id"=>BSON::ObjectId('529c692422139c0bd5decbe2'), "name"=>"Alice"}, …]
[27] pry(main)> users.find({}, fields: ["name", "age"]).sort(["age", "DESC"]).to_a
=> [{"_id"=>BSON::ObjectId('529c942784e1b6496c000004'),
  "name"=>"Clyde",
  "age"=>99},
 {"_id"=>BSON::ObjectId('529c942784e1b6496c000009'),
  "name"=>"Jakob",
  "age"=>90},
 …]

updating -- also available in both methods:

update with the whole object passed in:
[28] pry(main)> alice = users.find_one(name: "Alice")
=> {"_id"=>BSON::ObjectId('529c692422139c0bd5decbe2'),
 "address"=>"1 Main Street, London",
 "age"=>25.0,
 "hobbies"=>["sailing", "walking"],
 "name"=>"Alice",
 "status"=>"single"}
[29] pry(main)> alice["status"] = "married"
=> "married"
[30] pry(main)> users.update({name: "Alice"}, alice)
=> {"updatedExisting"=>true, "n"=>1, "connectionId"=>3, "err"=>nil, "ok"=>1.0}
[31] pry(main)> alice = users.find_one(name: "Alice")
=> {"_id"=>BSON::ObjectId('529c692422139c0bd5decbe2'),
 "address"=>"1 Main Street, London",
 "age"=>25.0,
 "hobbies"=>["sailing", "walking"],
 "name"=>"Alice",
 "status"=>"married"}

update with operators:
[32] pry(main)> users.update(
[32] pry(main)*   {age: {"$gt" => 30}},
[32] pry(main)*   {"$set" => {overThirty: true}},
[32] pry(main)*   {multi: true}
[32] pry(main)* )
=> {"updatedExisting"=>true, "n"=>8, "connectionId"=>3, "err"=>nil, "ok"=>1.0}
[34] pry(main)> users.find(overThirty: true).count
=> 8
[35] pry(main)> 2.times do
[35] pry(main)*   users.update(
[35] pry(main)*     {name: "upserted"},
[35] pry(main)*     {"$inc" => {age: 1}},
[35] pry(main)*     {upsert: true}
[35] pry(main)*   )
[35] pry(main)* end
=> 2
[36] pry(main)> users.find_one(name: "upserted")
=> {"_id"=>BSON::ObjectId('529c98b232f8f0aa9b188240'),
 "age"=>2, # because the first time it's 0+1, then the second time it's 1+1
 "name"=>"upserted"}

[37] pry(main)> users.find(name: "Gary").count
=> 1
[38] pry(main)> users.remove(name: "Gary")
=> {"n"=>1, "connectionId"=>3, "err"=>nil, "ok"=>1.0}
[39] pry(main)> users.find(name: "Gary").count
=> 0

[40] pry(main)> posts = db["posts"] # create new collection
=> #<Mongo::Collection:0x007f849db72900
 @acceptable_latency=15,
 …
[41] pry(main)> posts.count
=> 0
[42] pry(main)> db.collection_names
=> ["system.indexes", "users"] # mongo doesn't acknowledge this new posts collection because there's nothing in it
[43] pry(main)> posts.insert(title: "first post")
=> BSON::ObjectId('529c99a384e1b6496c00000c')
[44] pry(main)> posts.count
=> 1
[45] pry(main)> db.collection_names
=> ["system.indexes", "users", "posts"]

TO CREATE A NEW DATABASE:
[47] pry(main)> db2 = client.db("gallery_app") # we already created client before
=> #<Mongo::DB:0x007f849d85b8e8
 @acceptable_latency=15,
 …
[48] pry(main)> galleries = db2["galleries"];
[49] pry(main)> galleries.insert(name: "Jon's Gallery")
=> BSON::ObjectId('529c9a8784e1b6496c00000d')
[51] pry(main)> db2.collection_names
=> ["system.indexes", "galleries"]

TO DROP A DATABASE:
[52] pry(main)> client.drop_database("gallery_app")
=> {"dropped"=>"gallery_app", "ok"=>1.0}

3. RAILS WITH MONGODB (MONGOMAPPER)
----------------------------------------------------------------

➜  classwork git:(w10d1) ✗ rails new mongo_blog --skip-active-record

Gemfile
``````
gem 'mongo_mapper', "0.13.0.beta1"
gem 'bson_ext' # makes mongo processing faster
``````
bundle
rbenv rehash
hash -rf
mmconsole

config/application.rb
``````
    # Mongo
    config.generators do |g|
      g.orm :mongo_mapper
    end
```````

# mongo makes no distinction between string and text
➜  mongo_blog git:(w10d1) ✗ rails g scaffold post title:string content:string
      invoke  mongo_mapper
      create    app/models/post.rb
      invoke    test_unit
      create      test/unit/post_test.rb
      create      test/fixtures/posts.yml
      invoke  resource_route
       route    resources :posts
      invoke  scaffold_controller
      create    app/controllers/posts_controller.rb
      invoke    haml
      create      app/views/posts
      create      app/views/posts/index.html.haml
      create      app/views/posts/edit.html.haml
      create      app/views/posts/show.html.haml
      create      app/views/posts/new.html.haml
      create      app/views/posts/_form.html.haml
      invoke    test_unit
      create      test/functional/posts_controller_test.rb
      invoke    helper

app/models/post.rb:
``````
class Post
  include MongoMapper::Document

  key :title, String # typecast is not required
  key :content, String # typecast is not required

  timestamps! # no timestamps by default; need to put this in manually

end
``````

➜  mongo_blog git:(w10d1) ✗ rails g mongo_mapper:config
      create  config/mongo.yml

➜  mongo_blog git:(w10d1) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> p = Post.create(title: "First Post", content: Faker::Lorem.sentence)
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, title: "First Post", updated_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00>

➜  mongo_blog git:(w10d1) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> Post.all
P=> [#<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, title: "First Post", updated_at: Mon, 02 Dec 2013 16:22:07 UTC +00:00>]
[2] pry(main)> Post.first
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, title: "First Post", updated_at: Mon, 02 Dec 2013 16:22:07 UTC +00:00>
[3] pry(main)> Post.count
=> 1
[4] pry(main)> p = Post.first
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, title: "First Post", updated_at: Mon, 02 Dec 2013 16:22:07 UTC +00:00>
[5] pry(main)> Post.find p.id
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, title: "First Post", updated_at: Mon, 02 Dec 2013 16:22:07 UTC +00:00>
[6] pry(main)> p.id.class
=> BSON::ObjectId
[7] pry(main)> id_as_string = p.id.to_s
=> "529cb34084e1b65761000001"
[8] pry(main)> Post.find id_as_string
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, title: "First Post", updated_at: Mon, 02 Dec 2013 16:22:07 UTC +00:00>
[9] pry(main)> p.id # MongoMapper gives us just .id
=> BSON::ObjectId('529cb34084e1b65761000001')
[10] pry(main)> p._id # though ._id still works too
=> BSON::ObjectId('529cb34084e1b65761000001')
[11] pry(main)> p.to_mongo # version that gets sent to Mongo
=> {"_id"=>BSON::ObjectId('529cb34084e1b65761000001'),
 "title"=>"First Post",
 "content"=>"Omnis id molestiae quia dicta. Edit, edit.",
 "created_at"=>2013-12-02 16:20:16 UTC,
 "updated_at"=>2013-12-02 16:22:07 UTC}
[12] pry(main)> Post.new(title: 99)
=> #<Post _id: BSON::ObjectId('529cb4c584e1b657e6000001'), title: "99"> # typecast for title turns 99 into a string for us

CREATE NEW METHOD AUTOMAGICALLY:
[14] pry(main)> p["flagged"]
=> nil
[15] pry(main)> p["flagged"] = true
=> true
[16] pry(main)> p.flagged
=> true
[17] pry(main)> p.flagged = false
=> false
[18] pry(main)> p.flagged?
=> false
[19] pry(main)> p.save
=> true
[20] pry(main)> p.reload
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:29:06 UTC +00:00>

WE CAN DO THAT IN ROCKMONGO TOO:
update the post in RockMongo's view and add view_count: 0
[21] pry(main)> p.reload
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:29:06 UTC +00:00, view_count: 0.0>
[22] pry(main)> p.view_count
=> 0.0

point is, there's a lot of stuff we can do/add without modifying the post model

➜  mongo_blog git:(w10d1) ✗ rails g scaffold user name:string age:integer
      invoke  mongo_mapper
      create    app/models/user.rb
      invoke    test_unit
      create      test/unit/user_test.rb
      create      test/fixtures/users.yml

Loading development environment (Rails 3.2.14)
[1] pry(main)> jon = User.create(name: "Jon", age: 35)
=> #<User _id: BSON::ObjectId('529cb71d84e1b65945000001'), age: 35, created_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00, name: "Jon", updated_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00>
[2] pry(main)> p = Post.first
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:29:06 UTC +00:00, user_id: nil, view_count: 0.0> # because we added belongs_to :user
[3] pry(main)> p.user
=> nil
[4] pry(main)> p.user = jon
=> #<User _id: BSON::ObjectId('529cb71d84e1b65945000001'), age: 35, created_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00, name: "Jon", updated_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00>
[5] pry(main)> p.user.name
=> "Jon"
[6] pry(main)> p.save
=> true
[7] pry(main)> p.reload
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:38:07 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001'), view_count: 0.0>
[8] pry(main)> p.user.name
=> "Jon"
[9] pry(main)> jon.posts
=> [#<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:38:07 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001'), view_count: 0.0>]

and we can still do validations:
`````
  validates_presence_of :name
  validates_numericality_of :age
`````
then we can test in the console:
[4] pry(main)> u = User.new
=> #<User _id: BSON::ObjectId('529cb83684e1b659f1000001')>
[5] pry(main)> u.valid?
=> false
[6] pry(main)> u.errors.full_messages
=> ["Name can't be blank", "Age is not a number"]

great, now let's move on to comments, which we'll not scaffold but just create app/models/comment.rb:
````
class Comment
  include MongoMapper::EmbeddedDocument # because we're embedding comments in posts

  key :content, String

  timestamps!

  belongs_to :user

end
````
and update post.rb with just:
  has_many :comments # treat embedded docs as if they're associations

➜  mongo_blog git:(w10d1) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> p = Post.last
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:38:07 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001'), view_count: 0.0>
[2] pry(main)> u = User.last
=> #<User _id: BSON::ObjectId('529cb71d84e1b65945000001'), age: 35, created_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00, name: "Jon", updated_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00>
[3] pry(main)> c = Comment.new(content: Faker::Lorem.sentence, user_id: u.id)
=> #<Comment _id: BSON::ObjectId('529cb94e84e1b65a76000001'), content: "In commodi aut minima.", user_id: BSON::ObjectId('529cb71d84e1b65945000001')>
[4] pry(main)> p.comments << c
=> [#<Comment _id: BSON::ObjectId('529cb94e84e1b65a76000001'), content: "In commodi aut minima.", user_id: BSON::ObjectId('529cb71d84e1b65945000001')>]
[5] pry(main)> p.save
=> true
[6] pry(main)> p.reload
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), comments: [#<Comment _id: BSON::ObjectId('529cb94e84e1b65a76000001'), content: "In commodi aut minima.", created_at: Mon, 02 Dec 2013 16:47:16 UTC +00:00, updated_at: Mon, 02 Dec 2013 16:47:16 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001')>], content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:47:16 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001'), view_count: 0.0>

we'll now do something about view_count:
app/controllers/posts_controller.rb:
`````
  def show
    @post = Post.find(params[:id])

    @post.increment(view_count: 1) # .increment is a MongoMapper method
     …
  end
````

and in app/models/post.rb, we'll add:
  key :view_count, Integer
to make sure that field exists

then update the posts/show view to include this view_count
and we'll see that every time the show page is loaded, the view_count increments by 1

MongoMapper has a lot of query methods too:
[1] pry(main)> User.where(:age.gt => 16).all
=> [#<User _id: BSON::ObjectId('529cb71d84e1b65945000001'), age: 35, created_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00, name: "Jon", updated_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00>]
[2] pry(main)> User.where(:age.gt => 16).sort(:name).all
=> [#<User _id: BSON::ObjectId('529cb71d84e1b65945000001'), age: 35, created_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00, name: "Jon", updated_at: Mon, 02 Dec 2013 16:36:45 UTC +00:00>]

if you define a new method in post.rb:
`````
  def self.flagged
    where(flagged: true)
  end
`````
we can then call it!

[2] pry(main)> Post.flagged.all
=> []
➜  mongo_blog git:(w10d1) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> p = Post.last
=> #<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), comments: [#<Comment _id: BSON::ObjectId('529cb94e84e1b65a76000001'), content: "In commodi aut minima.", created_at: Mon, 02 Dec 2013 16:47:16 UTC +00:00, updated_at: Mon, 02 Dec 2013 16:47:16 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001')>], content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: false, title: "First Post", updated_at: Mon, 02 Dec 2013 16:47:16 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001'), view_count: 2>
[2] pry(main)> p.flagged
=> false
[3] pry(main)> p.flagged = true
=> true
[4] pry(main)> p.save
=> true
[5] pry(main)> Post.flagged.all
=> [#<Post _id: BSON::ObjectId('529cb34084e1b65761000001'), comments: [#<Comment _id: BSON::ObjectId('529cb94e84e1b65a76000001'), content: "In commodi aut minima.", created_at: Mon, 02 Dec 2013 16:47:16 UTC +00:00, updated_at: Mon, 02 Dec 2013 16:57:28 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001')>], content: "Omnis id molestiae quia dicta. Edit, edit.", created_at: Mon, 02 Dec 2013 16:20:16 UTC +00:00, flagged: true, title: "First Post", updated_at: Mon, 02 Dec 2013 16:57:28 UTC +00:00, user_id: BSON::ObjectId('529cb71d84e1b65945000001'), view_count: 2>]

new model: featured_post.rb:
`````
class FeaturedPost < Post

  key :price, Integer

end
`````
[7] pry(main)> fp = FeaturedPost.create(title: "Paid for post", content: Faker::Lorem.paragraph, price: 100)
=> #<FeaturedPost _id: BSON::ObjectId('529cbc9e84e1b65c04000001'), _type: "FeaturedPost", comments: [], content: "Quia quas non sint. Accusamus consectetur voluptatum ea voluptas perferendis et beatae. Assumenda neque dolorem atque ea accusantium mollitia. Ab nobis aut alias et voluptatibus labore.", created_at: Mon, 02 Dec 2013 17:00:14 UTC +00:00, price: 100, title: "Paid for post", updated_at: Mon, 02 Dec 2013 17:00:14 UTC +00:00, user_id: nil>
to Mongo, this post is still just a post BUT with "_type"

there's some full-text search in mongoDB:
Post.where(content: /^Quia/).all
=> #<FeaturedPost _id: …>

read more on positional operators:
https://jira.mongodb.org/browse/SERVER-831
