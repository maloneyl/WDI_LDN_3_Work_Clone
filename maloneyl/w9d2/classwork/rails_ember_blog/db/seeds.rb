User.delete_all
Post.delete_all

alice = User.new name: "Alice", email: "alice@alice.com", password: "password"
alice.admin = true
alice.save!

bob = User.create! name: "Bob", email: "bob@bob.com", password: "password"

md_content = <<MARKDOWN
Creating a list in **markdown** is easy:

* item 1
* item 2
* item 3

How cool is that!?
MARKDOWN

# Post.create! title: "Markdown is awesome", content: md_content
# Post.create! title: "Foo Bar Baz",         content: "Blah, blah blah..."

alice.posts.create! title: "Markdown is awesome", content: md_content
bob.posts.create!   title: "Foo Bar Baz",         content: "Blah, blah blah..."
