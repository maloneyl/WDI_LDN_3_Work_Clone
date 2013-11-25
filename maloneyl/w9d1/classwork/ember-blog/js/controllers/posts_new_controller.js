App.PostsNewController = Ember.ObjectController.extend({
  createPost: function(){
    title = this.get("title");
    body = this.get("body");
    post = App.Post.createRecord({
      title: title,
      body: body,
      posted: new Date()
      // brand: App.Brand.find(this.get("select_brand"))
    });

    this.transitionToRoute("posts.index");
  }
  // ,
  // brands: function(){
  //   return App.Brand.find();
  // }.property()
})
