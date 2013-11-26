App.CommentsNewController = Ember.ObjectController.extend({
  createComment: function(){
    var comment = App.Comment.createRecord({
      message: this.get("message"),
      posted: new Date(),
      post: App.Post.find(params.post_id)
    })
    comment.store.commit();
  }
})
