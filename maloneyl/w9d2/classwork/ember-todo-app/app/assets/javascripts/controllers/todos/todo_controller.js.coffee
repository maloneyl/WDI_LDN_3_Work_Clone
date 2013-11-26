EmberTodoApp.TodoController = Ember.ObjectController.extend
  actions:
    removeTodo: ->
      todo = @get("model")
      todo.deleteRecord()
      todo.save() # we save a deletion because this is how the request gets sent from client-side to server-side
  toggleStatus: ->
    model = @get("model")
    status = !!(model.get("status")) # get status AS OF when page is loaded, NOT after you check the box; !! to get it to true or false, not nil/undefined (default for new item created)
    model.set("status", !status) # set status to the opposite of existing status
    model.save()
