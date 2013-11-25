// ObjectController is meant for when we need to play with just one object
// ArrayController will be for collections
// Their parent is just Controller, which we'll never use
App.CarsNewController = Ember.ObjectController.extend({
  createCar: function(){
    // console.log(this.get("modelName"))
    name = this.get("modelName");
    car = App.Car.createRecord({
      modelName: name
    });

    this.transitionToRoute("cars.index"); // redirects after creation!
  }
})
