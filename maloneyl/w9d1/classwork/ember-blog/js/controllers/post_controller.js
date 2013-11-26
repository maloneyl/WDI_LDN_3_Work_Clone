App.PostController = Ember.ObjectController.extend({
  createComment: function(){
    debugger;
    var comment = App.Comment.createRecord({
      message: this.get("message"),
      posted: new Date(),
      post: App.Post.find(id: params.post_id)
    })
    comment.store.commit();
  }
})
