App.PostsNewController = Ember.ObjectController.extend
  actions:
    createPost: ->
      post = App.Post.createRecord
        title: @get('title')
        body: @get('body')
      post.save().then => # save on the server, and the post params sent is actually everything listed in user model here in Ember, so we'll normalize params and handle author/user on the Rails-side PostsController
      # ^ save doesn't happen instantly given all the stuff Rails has to do
      # if we simply do post.save(), javascript doesn't wait for .save to finish and will jump to the next line and transition BEFORE the updated post comes back from the server, i.e. also before the post comes with an ID (hence we see posts/null)
        @transitionToRoute 'post', post # the post needs a post id/object
