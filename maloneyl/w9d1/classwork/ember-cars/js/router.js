// by default, before creating this file, we'll see "Router: App.Router" when we inspect App in the Chrome dev-tool console
App.Router.map(function(){
  // this.resource("cars")
  this.resource("cars", {path: "/"}, function(){

  })
  // 'this' here represents the router
  // 'resource' -- think Rails -- though this doesn't give you all the create, edit, etc. too
  // also similar to Rails, following naming conventions means getting stuff generated for you automagically
  // so the line above gets us CarsIndex generated already
})

App.CarsIndexRoute = Ember.Route.extend({ // again, .extend takes a hash of parameters
  model: function(){
    return App.Car.find(); // Car is a model we define; get all data in this model with .find
  }
})
