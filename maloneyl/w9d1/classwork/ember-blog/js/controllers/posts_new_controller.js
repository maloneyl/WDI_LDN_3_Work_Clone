App.PostsNewController = Ember.ObjectController.extend({
  createPost: function(){
    var title = this.get("title");
    var body = this.get("body");
    var post = App.Post.createRecord({
      title: title,
      body: body,
      posted: new Date(),
      category: App.Category.find(this.get("categoryId"))
    });
    post.store.commit();
    this.transitionToRoute("posts");
  },

  categories: function(){
    return App.Category.find();
  }.property()
})
