EmberTodoApp.Task = DS.Model.extend
  # field names and types should match what we have on the server side
  name: DS.attr 'string'
  status: DS.attr 'boolean'
