QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

* Wish there were more/better documentations! It was rather hard to look things up and see conflicting answers (possibly because of version differences).
* Didn't have that much time last evening to finish the homework, sorry. Had some personal things to sort out. Will be better today!

HOMEWORK
---------
For today's lab, the objective is to create a simple blog app using the ember framework. It should contain Posts and Comments. Each Post can be linked to a Category. (You guessed it, this app requires 3 models: Post, Comment and Category). We will start it now, and tonight's homework is to finish the lab!

CLASS NOTES
============

1. JAVASCRIPT FRAMEWORKS (EMBER IN PARTICULAR)
----------------------------------------------------------------------------------

Backbone.js
created by Jeremy A
doesn't really scale, e.g. can't do something like gmail 
gmail - everything is javascript - doesn't need to reload (when you do, it warns you 'are you sure?' because there's a bunch of stuff that'll be reloaded and probably not what you want)

Ember.js
uses similar logic and convention as ruby on rails
so this is what we'll use in this course

Angular.js
by Google
most popular for the moment
doesn't follow Rails conventions

----

*Ember.js*

similar to rails; does MVC with templates and routing

MVCTR
model view controller template route
M, V, C - javascript objects; view is more like rails' equivalent of helper
T - equivalent of rails' views
R - also a javascript object; master object of the process (decides which M/V/C/T to use)

Handlebars.js
template engine used by Ember

we need these 4 files in our library to use ember:
- ember 1.0.0
- ember-data: link between server and our app
- custom handlebars
- jQuery

so in our index.html, we'll start with linking them in the body (because we only want them loaded after everything else):
`````
  <script src="./libs/jquery-1.9.1.js"></script>
  <script src="./libs/handlebars-1.0.0-rc.4.js"></script>
  <script src="./libs/ember-1.0.0-rc.6.1.js"></script>
  <script src="./libs/ember-data-0.13.js"></script>
`````

and we'll create a ./js/application.js:
````
// attach our app (named App) to the window
// because otherwise we won't be able to access this main object
// (CoffeeScript will wrap its functions before this line)
window.App = Ember.Application.create()

// now we can access App with just App
// DS (data store; with a Store property) is the handler of/how we access ember-data
// .extend takes a hash
App.Store = DS.Store.extend({ // we'll see "Store: App.Store" when we inspect App in the Chrome dev-tool console
  adapter: DS.FixtureAdapter // FixtureAdapter means hardcoded data; another adapter is DS.RESTAdapter (which does more stuff with the server)
})
````

and we'll define the routes in ./js/router.js:
````
// by default, before creating this file, we'll see "Router: App.Router" when we inspect App in the Chrome dev-tool console
App.Router.map(function(){
  this.resource("cars") // 'this' here represents the router
  // 'resource' -- think Rails
  // also similar to Rails, following naming conventions means getting stuff generated for you automagically
  // so the line above gets us CarsIndex generated already
})

App.CarsIndexRoute = Ember.Route.extend({ // again, .extend takes a hash of parameters
  model: function(){
    return App.Car.find(); // Car is a model we define; get all data in this model with .find
  }
})
````

and we'll create this Car model in ./js/models/car.js:
`````
// define our Car model
App.Car = DS.Model.extend({
  // define every field of model here
  // JSON object: key and value
  modelName: DS.attr("string")
})

App.Car.FIXTURES = [] // reminder: we defined DS.FixtureAdapter as the adapter
`````

now we'll be able to do something like:
car = App.Car.createRecord({modelName: "Delorean"})
> Class {store: Class, currentState: Object, _changesToSync: Object, transaction: Class, _reference: Object…}
car.get("modelName")
> "Delorean"
car.modelName # note that in Ember, we need the .get function instead, not access attributes directly
> undefined
car.set("modelName", "Boom")
> Class {store: Class, _changesToSync: Object, transaction: Class, _reference: Object, _data: Object…}
car.get("modelName")
> "Boom"
cars = App.Car.find()
> Class {type: function, store: Class, isLoaded: true, isUpdating: true, constructor: function…}
cars.get("length")
> 2

and let's try out templating by adding this to the top of our scripts:
````
  <script type="text/x-handlebars" data-template-name="application">
    <h1>Cars Application</h1>
    {{outlet}}
  </script>
`````
and voila! index.html now comes with that template. convention over configuration. by naming this 'application', we don't need to call it explicitly.
{{outlet}} is yield

if we want something to help us debug, we can do some logging by adding this in our application.js:
`````
window.App = Ember.Application.create({
  LOG_TRANSITIONS: true
});
`````

to get a template in for cars/index, we'll first need to fix the routes:
`````
  this.resource("cars", {path: "/"}, function(){

  })
`````
note that resource in Ember doesn't give you all the create, edit, etc. too

now we can see our template named data-template-name="cars/index" used when we access index.html

we'll move on to controller next
a controller is still a javascript object
if we stick {{controller}} just before our {{outlet}} in that application template, we'll see this printed:
	<(generated application controller):ember249>

an Ember controller is more like a Rails controller ACTION

````````
  <script type="text/x-handlebars" data-template-name="cars/index">
    <h2>Cars</h2>
    <ul>
      {{#each controller}} // open each tag with #
        <li>{{modelName}}</li> // we can call this directly because we've specified the controller in the opening 'each'
      {{/each}} // close each tag with /
    </ul>
  </script>
````````
and now we go into the console and do things like:
	car = App.Car.createRecord({modelName: "Delorean"})
we'll see that popup in the template automagically!

we can print {{controller.content}} to see:
	<DS.RecordArray:ember254>
which is a collection of the object App.Car

an alternative way to do what we did before is this:
```````
    {{controller.content}}
    <ul>
      {{#each car in controller}} # mention 'car'
        <li>{{car.modelName}}</li> # now we need to do 'car.modelName'
      {{/each}}
    </ul>
```````

how to create links:
```````
    {{#linkTo "cars.index"}}View all Cars{{/linkTo}}
    {{#linkTo "cars.new"}}Create a new Car{{/linkTo}}
```````
and we'll see that the right templates load, the URL change, but there is no page reloading

<(generated cars.new controller):ember307> 
ember307, emberXXX, etc. are the IDs

let's build the create car:
``````
  <script type="text/x-handlebars" data-template-name="cars/new">
    <h2>Create new Car</h2>
    {{controller}}
    <form {{action "createCar" on="submit"}}> # this means trigger onclick event on submission
      {{view Ember.TextField valueBinding="modelName"}}
      <button>Create</button>
    </form>
  </script>
``````
and what's missing is the controller, so we'll create: ./js/controllers/cars_new_controller.js:
`````
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
`````
note that we must always load the script on our index.html
otherwise, we'll see that ember keeps using its own generated controller, which will then give us the nothing handling that createCar method error
when ember uses our controller, we'll see that explicitly: <App.CarsNewController:ember229>

car = App.Car.find().get("firstObject")
> Class {id: "1", store: Class, _reference: Object, _changesToSync: Object, transaction: Class…}
car.get("brand")
> Class {id: "1", store: Class, _reference: Object, currentState: Object, _changesToSync: Object…}
car.get("brand").get("name")
> "Rolls Royce"
car.get("brand.name")
> "Rolls Royce"
but there is some subtle difference:
car.get("brande.name")
> undefined
car.get("brande").get("name")
> TypeError: Cannot call method 'get' of undefined

Ember Chrome extension is a nifty thing to install

in-place editing! see classwork: address-book app

there are partials in ember too

2. MORE EMBER
--------------------------

  <script type="text/x-handlebars" data-template-name="application">
is the same as just:
  <script type="text/x-handlebars">
because again, naming conventions.

./js/script.js:
````````
window.App = Ember.Application.create(); // remember: window.App!

App.Store = DS.Store.extend({
  adapter: DS.FixtureAdapter
})

App.Router.map(function(){
  this.resource("contacts", {path: "/"}) // i.e. map contacts with root
})

App.ContactsRoute = Ember.Route.extend({
  model: function(){

  }
})

App.Person = DS.Model.extend({
  first: DS.attr("string"),
  last: DS.attr("string"),
  phone: DS.attr("number") // no difference between float and integer in Ember
})

App.Person.FIXTURES = [
  {id: 1, first: "Gerry", last: "Mathe", phone: "01234567890"},
  {id: 2, first: "Jon", last: "Chambers", phone: "09876543210"}
]
````````
if that works, in the console, we can do:
contacts = App.Person.find()
> Class {type: function, … }
contacts.get("length")
> 2

in Ember, you do if, else, end with:
{{#if}} {{else}} {{/if}}

you can bind action in divs:
            <div {{action "editContact" on="doubleClick"}}>Something</div>
