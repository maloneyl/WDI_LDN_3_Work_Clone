App.Brand = DS.Model.extend({
  name: DS.attr("string"),
  cars: DS.hasMany("App.Car") // yep, Rails-like associations
})

App.Brand.FIXTURES = [
  {id: 1, name: "Rolls Royce"},
  {id: 2, name: "Bentley"}
]
