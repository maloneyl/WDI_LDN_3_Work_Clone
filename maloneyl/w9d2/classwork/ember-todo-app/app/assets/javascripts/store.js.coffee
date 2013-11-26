# http://emberjs.com/guides/models/defining-a-store/

EmberTodoApp.Store = DS.Store.extend
  revision: 11
  adapter: DS.RESTAdapter.create() # RESTAdapter is default

