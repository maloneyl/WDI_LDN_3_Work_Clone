// first thing you do in Ember
window.App = Ember.Application.create(); // remember: window.App!

App.Store = DS.Store.extend({
  adapter: DS.FixtureAdapter
})

App.Router.map(function(){
  this.resource("contacts", {path: "/"}) // i.e. map contacts with root
})

App.ContactsRoute = Ember.Route.extend({
  model: function(){
    return App.Person.find();
  }
})

// create Category model
App.Category = DS.Model.extend({
  name: DS.attr("string"),
  persons: DS.hasMany("App.Person")
})

App.Category.FIXTURES = [
  {id: 1, name: "Family"},
  {id: 2, name: "Friends"},
  {id: 3, name: "Professional"}
]

// create Person model
App.Person = DS.Model.extend({
  first: DS.attr("string"),
  last: DS.attr("string"),
  phone: DS.attr("number"), // no difference between float and integer in Ember
  category: DS.belongsTo("App.Category")
})

// get basic data in
App.Person.FIXTURES = [
  {id: 1, first: "Gerry", last: "Mathe", phone: "01234567890", category: 1},
  {id: 2, first: "Jon", last: "Chambers", phone: "09876543210", category: 2}
]

// this is what the itemController in our application template refers to
// singular ContactController because we have one controller per person
// can prove by printing {{controller}} {{first}}: <App.ContactController:ember280> Gerry, <App.ContactController:ember285> Jon
// we can map any controller to any model, hence our ContractController is meant for Person model
App.ContactController = Ember.ObjectController.extend({
  isEditing: false,
  editContact: function(){ // editContact is a function that's trigged on double-click, based on what's specified in our application template
    this.set("isEditing", true);
  },
  saveContact: function(){
    // console.log(this.get("model").get("first")); // can see that first name gets updated automatically, thanks to proper naming conventions
    person = this.get("model");
    category = App.Category.find(this.get("categoryId"));
    person.set("category", category);
    person.save();
    this.set("isEditing", false);
  },
  deleteContact: function(){
    var contact = this.get("model"); // 'model' means current instance of the store
    contact.deleteRecord(); // remove the record from the store (local)
    contact.save(); // send the request to the server; and we can't chain .deleteRecord().save() because .deleteRecrd() returns nil
  },
  selectedCategory: function(){
    return App.Category.find(this.get("category.id"));
  }.property(), // already bound ^
  categories: function(){
    return App.Category.find(); // return all categories
  }.property()
})

// ArrayController here because we're dealing with ALL contacts, i.e. a collection
// ObjectController can only manage a simple instance of an object, e.g. it can't even handle our 'each' in the template if we change below to ObjectController
App.ContactsController = Ember.ArrayController.extend({
  createContact: function(){
    var contact = App.Person.createRecord({ // create locally in the store
      first: this.get("first"),
      last: this.get("last"),
      phone: this.get("phone"),
      category: App.Category.find(this.get("categoryId"))
    })
    contact.store.commit(); // freeze the current state of the store before more changes (like trying to edit that newly created record)
  },
  // countContacts: function(){
  //   return [this.get("length"), "contacts"].join(" ") // given our template position vis-a-vis the source, this calculation is done before our fixtures is initialized IF we don't pass .property("length") and just do .property()
  // }.property("length"); // return the property, not the function text; .property("length") prompts Ember to recalculate every time .property("length") is changed; without this, Ember will just give you the property once it's loaded
  countContacts: function(){
    return this.get("length") // given our template position vis-a-vis the source, this calculation is done before our fixtures is initialized IF we don't pass .property("length") and just do .property()
  }.property("length"), // return the property, not the function text; .property("length") prompts Ember to recalculate every time .property("length") is changed; without this, Ember will just give you the property once it's loaded
  contactInflection: function(){
    return this.get("length") == 1 ? "contact" : "contacts"
  }.property("length"),
  categories: function(){ // we need this because our partial to create a new contact is under this ContactsController instead of ContactController; we don't need selectedCategory here becuase, well, there's no selectedCategory yet with a new contact to be created
    return App.Category.find(); // return all categories
  }.property()
})
