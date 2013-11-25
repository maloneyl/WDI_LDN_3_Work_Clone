// ObjectController is meant for when we need to play with just one object
// ArrayController will be for collections
// Their parent is just Controller, which we'll never use
App.CarsNewController = Ember.ObjectController.extend({
  createCar: function(){
    // console.log(this.get("modelName"))
    name = this.get("modelName");
    car = App.Car.createRecord({
      modelName: name,
      brand: App.Brand.find(this.get("select_brand")) // pass the brand object by finding/matching it with what we've got in select_brand (see create form)
    });

    this.transitionToRoute("cars.index"); // redirects after creation!
  }, // we're still in the hash of extend params

  brands: function(){ // we bind brands in the create form
    return App.Brand.find();
  }.property() // without .property(), ___.brand will just return this object: the whole function's TEXT (like "function(){ ... }"); and we can call .property() on an object
})
