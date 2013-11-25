window.App = Ember.Application.create({
});

App.Store = DS.Store.extend({
  adapter: DS.FixtureAdapter
})
