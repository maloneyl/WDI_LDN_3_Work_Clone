// by default, before creating this file, we'll see "Router: App.Router" when we inspect App in the Chrome dev-tool console
App.Router.map(function(){
  // this.resource("cars")
  this.resource("cars", {path: "/"}, function(){
    this.route("new") // we need to do this ourselves because there's no automagic
  })
  // 'this' here represents the router
  // 'resource' -- think Rails -- though this doesn't give you all the create, edit, etc. too, so we'll have to create our own
  // also similar to Rails, following naming conventions means getting stuff generated for you automagically
  // so the line above gets us CarsIndex generated already
})

App.CarsIndexRoute = Ember.Route.extend({ // again, .extend takes a hash of parameters
  model: function(){
    return App.Car.find(); // get all data in this App.Car model with .find()
  }
})

App.CarsNewRoute = Ember.Route.extend({
  model: function(){
    return App.Car;
  }
})
