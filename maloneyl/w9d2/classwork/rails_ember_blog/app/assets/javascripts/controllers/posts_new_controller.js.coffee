App.PostsNewController = Ember.ObjectController.extend
  actions:
    createPost: ->
      title = @get("title")
      body = @get("body")
      post = @createRecord(App.Post, {
        title: title,
        body: body,
        date_posted: new Date(),
        author: currentUser
      })
      post.store.commit()
      post.save()

      $.ajax
        url: App.urls.posts_new
        type: "POST"
        data:
          "post[title]": route.currentModel.title
          "post[content]": route.currentModel.body
          "post[created_at]": route.currentModel.date_posted
          "post[user_id]": route.currentModel.author # ?
        success: (data) ->
          route.transitionTo 'posts'
        error: (jqXHR, textStatus, errorThrown) ->
          route.controllerFor('posts_new').set "errorMsg", "Error!"
