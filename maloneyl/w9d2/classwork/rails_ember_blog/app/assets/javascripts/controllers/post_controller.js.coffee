App.PostController = Ember.ObjectController.extend
  needs: ['auth'] # needs AuthController to be loaded
  isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated" # now we can use this in our logic!
  actions:
    isEditing: false
    deletePost: ->
      if confirm 'Are you sure?'
        post = @get('model')
        post.deleteRecord()
        post.save()
        @transitionToRoute 'posts'
    editPost: ->
      @set('isEditing', true)
    savePost: ->
      post = @get('model')
      post.save().then =>
        # @transitionToRoute 'post', post
        post.reload()
      @set('isEditing', false)

