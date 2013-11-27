# for more details see: http://emberjs.com/guides/models/defining-models/

App.Post = DS.Model.extend
  title: DS.attr 'string'
  body: DS.attr 'string' # note that this is still "content" on the Rails side, but we can remedy that later
  date: DS.attr 'date' # we'll be sending the datestamp from Rails to here
  lastUpdatedAt: DS.attr 'date' # Ember will know that lastUpdatedAt here relates to last_updated_at sent from the API

  canUpdate: DS.attr 'boolean' # Ember will know that canUpdate here relates to can_update sent from the API
  canDestroy: DS.attr 'boolean' # Ember will know that canDestroy here relates to can_destroy sent from the API

  author: DS.belongsTo 'App.User' # i.e. within the context of a post, we have an author field which gets a User id

# ORIGINAL VERSION GENERATED WHEN WE SCAFFOLDED
# App.Post = DS.Model.extend
#   title: DS.attr 'string'
#   content: DS.attr 'string'
#   author: DS.belongsTo 'App.User'
