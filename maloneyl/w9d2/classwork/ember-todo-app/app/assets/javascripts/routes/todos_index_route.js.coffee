EmberTodoApp.TodosIndexRoute = Ember.Route.extend
  model: ->
    EmberTodoApp.Task.find()
