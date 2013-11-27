# For more information see: http://emberjs.com/guides/routing/

App.Router.map ->
  @resource 'posts', ->

    # get this nested URL: posts/:post_id
    # if the path is not defined, it'll be just: posts
    @resource 'post', path: '/:post_id' # :post_id is a dynamic segment, which will let us get a params object/"hash" and make the dynamic segment the value (just like in Rails)
    @route 'new'

  @route 'about' # route is similar to get/put/match, doesn't generate [name].index for you, and cannot be nested
  @route 'login'
  @route 'registration'

# if you nest a route, you nest a view too: the child's view will be nested in the parent's view's outlet
# e.g.
#   routes: posts -> post
#   views: posts.hbs {{outlet}} -> post.hbs

# reminder: make a route object every time you make a new route!
