// router
App.Router.map(function(){
  this.resource("posts", {path: "/"}, function(){
    this.route("new")
  })
})

// individual routes
App.PostsIndexRoute = Ember.Route.extend({
  model: function(){
    return App.Post.find();
  }
})

App.PostsNewRoute = Ember.Route.extend({
  model: function(){
    return App.Post;
  }
})
