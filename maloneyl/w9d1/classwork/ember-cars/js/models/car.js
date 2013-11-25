// define our Car model
App.Car = DS.Model.extend({
  // define every field of model here
  // JSON object: key and value
  modelName: DS.attr("string")
})

App.Car.FIXTURES = [ // reminder: we defined DS.FixtureAdapter as the adapter
  {id: 1, modelName: "Rolls Phantom"},
  {id: 2, modelName: "Bently Continental"},
  {id: 3, modelName: "Boom"}
]

// in the console, we'll can add to the list and do something like:
// car = App.Car.createRecord({modelName: "Delorean"})
// > Class {store: Class, currentState: Object, _changesToSync: Object, transaction: Class, _reference: Object…}
// car.get("modelName")
// > "Delorean"
// car.modelName # note that in Ember, we need the .get function instead, not access attributes directly
// > undefined
// car.set("modelName", "Boom")
// > Class {store: Class, _changesToSync: Object, transaction: Class, _reference: Object, _data: Object…}
// car.get("modelName")
// > "Boom"
// cars = App.Car.find()
// > Class {type: function, store: Class, isLoaded: true, isUpdating: true, constructor: function…}
// cars.get("length")
// > 2
