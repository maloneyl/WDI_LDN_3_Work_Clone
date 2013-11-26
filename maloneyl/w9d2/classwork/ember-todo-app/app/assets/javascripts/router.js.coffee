# For more information see: http://emberjs.com/guides/routing/

EmberTodoApp.Router.map ()->
  @resource 'todos', {path: '/'}, ->
    @route 'active'
    @route 'completed'


