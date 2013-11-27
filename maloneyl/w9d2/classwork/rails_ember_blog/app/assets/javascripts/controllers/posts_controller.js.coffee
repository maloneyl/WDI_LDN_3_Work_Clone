# before we created this, we've been relying on the automagically created one
# we are buidling this now because we want to have more values/logic to use in our posts template (which looks for values first in the model and then in the controller)

App.PostsController = Ember.ArrayController.extend
  needs: ['auth'] # needs AuthController to be loaded
  isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated" # now we can use this in our logic!
  actions:
    new: ->
      @transitionToRoute 'posts.new'
