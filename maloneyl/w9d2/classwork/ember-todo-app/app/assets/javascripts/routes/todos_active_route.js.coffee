EmberTodoApp.TodosActiveRoute = Ember.Route.extend
  model: ->
    EmberTodoApp.Task.filter (todo) -> # yes, we can .filter instead of .find; it's essentially a .map, returning an array of items where condition is true
      !todo.get("status") # match where status is false

  renderTemplate: (controller) ->
    @render("todos/index", {controller: controller}) # every template needs a controller
