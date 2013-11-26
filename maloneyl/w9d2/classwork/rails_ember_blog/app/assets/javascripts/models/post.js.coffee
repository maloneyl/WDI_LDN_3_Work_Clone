# for more details see: http://emberjs.com/guides/models/defining-models/

App.Post = DS.Model.extend
  title: DS.attr 'string'
  body: DS.attr 'string' # note that this is still "content" on the Rails side, but we can remedy that later
  date: DS.attr 'date' # we'll be sending the datestamp from Rails to here
  author: DS.belongsTo 'App.User' # i.e. within the context of a post, we have an author field which gets a User id

# ORIGINAL VERSION GENERATED WHEN WE SCAFFOLDED
# App.Post = DS.Model.extend
#   title: DS.attr 'string'
#   content: DS.attr 'string'
#   author: DS.belongsTo 'App.User'
