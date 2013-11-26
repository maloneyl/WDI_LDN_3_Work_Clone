// router
App.Router.map(function(){
  this.resource("posts", {path: "/"}, function(){
    this.route("new");
    this.resource("post", {path: "post/:post_id"}, function(){
      this.route("edit");
      this.resource("comments", function(){
        this.route("new");
      })
    })
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

App.PostRoute = Ember.Route.extend({
  model: function(params){
    return App.Post.find(params.post_id);
  }
})

// App.PostIndexRoute = Ember.Route.extend({
//   model: function(params){
//     return App.Post.find(params.post_id);
//   }
// })
