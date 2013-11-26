EmberTodoApp.TodosController = Ember.ArrayController.extend
  actions: # every action to follow should be in a hash
    createTodo: ->
      title = @get("newTitle") # @ is CoffeeScript for this.; newTitle is the value on our input form
      todo = @store.createRecord(EmberTodoApp.Task, {name: title}) # store is global for our app
      todo.save()

  # not an action and not a function, but a property
  remaining: ( ->
    @filterBy("status", false).get("length")
  ).property("@each.status") # recompute this property every time the status of any item in the collection changes

  # not an action and not a function, but a property
  inflection: ( ->
    remaining = @get("remaining") # chained to remaining above; so each time the status of any item in the collection changes, remaining above is triggered, which then triggers this inflection
    if remaining == 1 then "item" else "items" # CoffeeScript ternary operator; return automatic
  ).property("remaining")
