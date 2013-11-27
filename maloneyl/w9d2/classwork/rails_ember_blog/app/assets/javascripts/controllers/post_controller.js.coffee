App.PostController = Ember.ObjectController.extend
  needs: ['auth'] # needs AuthController to be loaded
  isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated" # now we can use this in our logic!
  actions:
    deletePost: ->
      if confirm 'Are you sure?'
        post = @get('model')
        post.deleteRecord()
        post.save().then =>
          @transitionToRoute 'posts'
