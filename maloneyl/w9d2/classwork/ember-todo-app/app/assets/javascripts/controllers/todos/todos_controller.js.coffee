EmberTodoApp.TodosController = Ember.ArrayController.extend
  actions: # every action to follow should be in a hash
    createTodo: ->
      title = @get("newTitle") # @ is CoffeeScript for this.; newTitle is the value on our input form
      todo = @store.createRecord(EmberTodoApp.Task, {name: title}) # store is global for our app
      todo.save()
