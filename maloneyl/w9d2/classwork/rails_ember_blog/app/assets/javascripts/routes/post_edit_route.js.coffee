App.PostEditRoute = Ember.Route.extend
  model: (params) ->
    App.Post.find(params.post_id)
