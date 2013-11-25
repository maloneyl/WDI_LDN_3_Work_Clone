// attach our app (named App) to the window
// because otherwise we won't be able to access this main object
// (CoffeeScript will wrap its functions before this line)
window.App = Ember.Application.create({
  LOG_TRANSITIONS: true
});

// now we can access App with just App
// DS (data store; with a Store property) is the handler of/how we access ember-data
// .extend takes a hash
App.Store = DS.Store.extend({ // we'll see "Store: App.Store" when we inspect App in the Chrome dev-tool console
  adapter: DS.FixtureAdapter // FixtureAdapter means hardcoded data; another adapter is DS.RESTAdapter (which we'll use to link with Rails/do server stuff with AJAX)
})

