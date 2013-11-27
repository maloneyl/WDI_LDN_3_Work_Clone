QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================


HOMEWORK
---------

For each post, display 'Updated at [TIME]; Created at [TIME]' if and only if it is necessary (i.e. if there has been an update, indicated by the different timestamps).

Bonus:
If a user is authenticated, link to and display a new form in the slave/child view (i.e. where the post content is shown now) for the user to create a new post. Note that the post content is named 'body' in Ember and 'content' in Rails.



CLASS NOTES
============

0. HOMEWORK REVIEW
------------------------------------

if nesting resources, put each resource in a folder: e.g. controllers/posts, controllers/comments
and there should be one controller per route

to be able to do edit-in-place or anything item-specific, use the itemController,
e.g. in posts, controlled by PostsController, we can do:
  {{#each post in controller itemController="PostController"}}
then each of those items will be connected to the PostController instead of the PostsController
then find and do things to the post with this.get("model")


1. EMBER WITH RAILS
---------------------------------

http://todomvc.com/
"a project which offers the same Todo application implemented using MV* concepts in most of the popular JavaScript MV* frameworks of today"

to use Ember with Rails:
gem 'ember-rails', '~> 0.13.0'
gem 'ember-source', '1.0.0.rc8'

now with rails g, we can generate a bunch of ember stuff:
Ember:
  ember:bootstrap
  ember:controller
  ember:install
  ember:model
  ember:resource
  ember:route
  ember:template
  ember:view

we'll use the bootstrap one, which is kind of like scaffolding:
➜  ember-todo-app git:(w9d2-maloneyl) ✗ rails g ember:bootstrap
No ember.js variant was specified in your config environment.
You can set a specific variant in your application config in
order for sprockets to locate ember's assets:

    config.ember.variant = :development

Valid values are :development and :production
      insert  app/assets/javascripts/application.js.coffee
      insert  app/assets/javascripts/application.js
      create  app/assets/javascripts/models
      create  app/assets/javascripts/models/.gitkeep
      create  app/assets/javascripts/controllers
      create  app/assets/javascripts/controllers/.gitkeep
      create  app/assets/javascripts/views
      create  app/assets/javascripts/views/.gitkeep
      create  app/assets/javascripts/routes
      create  app/assets/javascripts/routes/.gitkeep
      create  app/assets/javascripts/helpers
      create  app/assets/javascripts/helpers/.gitkeep
      create  app/assets/javascripts/templates
      create  app/assets/javascripts/templates/.gitkeep
      create  app/assets/javascripts/ember_todo_app.js.coffee
      create  app/assets/javascripts/router.js.coffee
      create  app/assets/javascripts/store.js.coffee

application.js now has this line that's responsible for loading all those files in our app:
  //= require ember_todo_app
if we remove that line, we'll remove all ember

and we'll add that config line that we're told to add in that generation message
EXCEPT we'll also add it to production (changing to :production, of course)

note that DS.RESTAdapter is the default in store

➜  ember-todo-app git:(w9d2-maloneyl) ✗ rails g migration CreateTasks
➜  ember-todo-app git:(w9d2-maloneyl) ✗ rake db:migrate

in app/controllers/tasks_controller.rb:
```````
class TasksController < ApplicationController
  def index
    respond_to do |format|
      format.html {render nothing: true, layout: true} # i.e. render empty layout to make room for our Ember yield
    end
  end
end
````````

then in app/assets/javascripts/router.js.coffee:
````````
EmberTodoApp.Router.map ()->
  @resource 'todos', {path: '/'}, ->
````````

and we want to track our routes, so let's edit app/assets/javascripts/application.js:
````````
window.EmberTodoApp = Ember.Application.create({
  LOG_TRANSITIONS: true
});
````````

and we'll create an index route in app/assets/javascripts/routes/todos_index_route.js.coffee:
````````
EmberTodoApp.TodosIndexRoute = Ember.Route.extend
  model: ->
    [] # empty array to start
````````

and an overall app template in app/assets/javascripts/templates/todos.hbs:
````````
<section id="todoapp">
  <header id="header">
    <h1>To-Do's</h1>
  </header>

  <section id="main">
    {{outlet}}
  </section>
</section>
````````

and we'll add a template for that TodosIndex: app/assets/javascripts/templates/todos/index.hbs:
````````
````````

and a model for that TodosIndex: tasks.js.coffee:
```````
EmberTodoApp.Task = DS.Model.extend
  # field names and types should match what we have on the server side
  name: DS.attr 'string'
  status: DS.attr 'boolean'
```````
and we'll update our todos_index_route.js.coffee to map the model to:
  EmberTodoApp.Task.find()
and also add this format to our tasks_controller.rb:
  format.json {render json: {tasks: Task.all}} # notes: 1. Task here refers to task.rb (which we'll create in app/models); 2. there will be a gem we can use in the future for this rendering

the Task model on the server side is:
```````
class Task < ActiveRecord::Base
  attr_accessible :name, :status
end
```````

now if we go to the site and into the console, under Network - XHR - Response, we should see {"tasks":[]}

great, let's go back to add to our layout in app/assets/javascripts/templates/todos.hbs:
```````
{{input type="text" id="new-todo" placeholder="What needs to be done" value=newTitle action="createTodo"}}
````````
notes:
{{input type="text"}} is the same as {{view Ember.TextField}}
newTitle is not in quotes because it's actually a variable

todos_controller.js.coffee:
`````````
EmberTodoApp.TodosController = Ember.ArrayController.extend
  actions: # every action to follow should be in a hash
    createTodo: ->
      title = @get("newTitle") # @ is CoffeeScript for this.; newTitle is the value on our input form
      console.log(title)
      todo = @store.createRecord(EmberTodoApp.Task, {name: title}) # store is global for our app
      todo.save()
`````````
things are save on the UI now
still need to link to our server:
tasks_controller.rb:
````````
  def create
    task = Task.create params[:task] # params is the object from ember
    render json: {task: task}
  end
````````
now the record is persisted! stays after refreshing because it's actually in our DB.

add to our app, the checkbox: app/assets/javascripts/views/checkbox_status_view.js.coffee:
`````
EmberTodoApp.CheckboxStatusView = Ember.Checkbox.extend # we are extending from Ember's native Checkbox class
  isChecked: true
  classNames: ["toggle"] # css
  change: -> @get("controller").toggleStatus() # change: trigger our action on change; need to write toggleStatus function
`````

and we update our todos/index.hbs:
`````````
<ul id="todo-list">
  {{#each controller itemController="todo"}}
    <li>
      {{view EmberTodoApp.CheckboxStatusView checkedBinding="status"}} # status in a boolean
      <label>{{name}}</label>
    </li>
  {{/each}}
</ul>
```````

then we need to build that todo controller:
``````
EmberTodoApp.TodoController = Ember.ObjectController.extend
  toggleStatus: ->
    model = @get("model")
    status = !!(model.get("status")) # get status as of when page is loaded: get it to true or false, not nil/undefined (default for new item created)
    model.set("status", !status) # aset status to the opposite of existing status
    model.save()
``````

and now we also need to update our server-side task_controller.rb to do an update:
``````
  def update
    task = Task.find params[:id]
    task.update_attributes params[:task]
    render json: {task: task}
  end
``````
now our checked/unchecked status is persisted



ADDING DELETE FUNCTION:

so now we'll move on to adding a delete function:
start adding a button in the layout:
  <button {{action "removeToDo"}} class="destroy"></button>
and class above is meant for CSS

then update the TodoController:
``````
EmberTodoApp.TodoController = Ember.ObjectController.extend
  actions:
    removeTodo: ->
      todo = @get("model")
      todo.deleteRecord()
      todo.save() # we save a deletion because this is how the request gets sent from client-side to server-side
  toggleStatus: ->
    model = @get("model")
    status = !!(model.get("status")) # get status AS OF when page is loaded, NOT after you check the box; !! to get it to true or false, not nil/undefined (default for new item created)
    model.set("status", !status) # set status to the opposite of existing status
    model.save()

``````

then the server-side TaskController:
`````
  def destroy
    task = Task.find params[:id]
    task.delete
    render nothing: true # Ember expects an empty response
  end
`````


ADDING FILTERING

start with router:
`````
EmberTodoApp.Router.map ()->
  @resource 'todos', {path: '/'}, ->
    @route 'active'
    @route 'completed'
`````
(and we'll have to create a todos_active_route.js.coffee and a todos_completed_route.js.coffee)

and we can now link to on our todos.hbs:
``````
  <footer id="footer">
    <ul id="filters">
      <li>{{#linkTo "todos"}}All{{/linkTo}}</li>
      <li>{{#linkTo "todos.active"}}Active{{/linkTo}}</li>
      <li>{{#linkTo "todos.completed"}}Completed{{/linkTo}}</li>
    </ul>
  </footer>
``````

then map the model with the new routes:
1) app/assets/javascripts/routes/todos_active_route.js.coffee
`````````
EmberTodoApp.TodosActiveRoute = Ember.Route.extend
  model: ->
    EmberTodoApp.Task.filter (todo) -> # yes, we can .filter instead of .find; it's essentially a .map, returning an array of items where condition is true
      !todo.get("status") # match where status is false

  renderTemplate: (controller) ->
    @render("todos/index", {controller: controller}) # every template needs a controller
`````````
2) app/assets/javascripts/routes/todos_completed_route.js.coffee:
`````````
EmberTodoApp.TodosCompletedRoute = Ember.Route.extend
  model: ->
    EmberTodoApp.Task.filter (todo) -> # yes, we can .filter instead of .find; it's essentially a .map, returning an array of items where condition is true
      todo.get("status") # match where status is true

  renderTemplate: (controller) ->
    @render("todos/index", {controller: controller}) # every template needs a controllers
`````````

ADD COUNT:

again, easy bit first: add this on the layout:
````````
    <span id="todo-count">
      <strong>{{remaining}}</strong> {{inflection}} left
    </span>
````````

then work on those remaining and inflection PROPERTIES:
````````
EmberTodoApp.TodosController = Ember.ArrayController.extend
  actions: # every action to follow should be in a hash
    createTodo: ->
      title = @get("newTitle") # @ is CoffeeScript for this.; newTitle is the value on our input form
      todo = @store.createRecord(EmberTodoApp.Task, {name: title}) # store is global for our app
      todo.save()

  # not an action and not a function, but a property
  remaining: ( ->
    @filterBy("status", false).get("length")
  ).property("@each.status") # recompute this property every time the status of any item in the collection changes

  # not an action and not a function, but a property
  inflection: ( ->
    remaining = @get("remaining") # chained to remaining above; so each time the status of any item in the collection changes, remaining above is triggered, which then triggers this inflection
    if remaining == 1 then "item" else "items" # CoffeeScript ternary operator; return automatic
  ).property("remaining")
````````

2. EMBER WITH RAILS AND DEVISE
----------------------------------------------------

classwork: rails_ember_blog

if we don't customize, ember will generate a javascript object named the same as our file name, i.e. RailsEmberBlog

to customize that name, BEFORE WE GENERATE ANYTHING, we can add this to our config/application.rb:
  config.ember.app_name = 'App'

this way we can more easily copy and paste other people's code AND reuse our code in the future (most Ember apps are just called App)

as we're using postgresql, we need to run rake db:create first before we can generate ember with this line:
➜  rails_ember_blog git:(w9d2-maloneyl) ✗ rails g ember:bootstrap --javascript-engine coffee
(whether or not CoffeeScript needs to be specified above to become default depends on the version of Ember/Rails…)

we'll see in app/javascripts that the old application.js is still there along with application.js.coffee
so we'll get rid of application.js BUT copy these jquery lines from application.js to paste in application.js.coffee:
#= require jquery
#= require jquery_ujs

look up: difference between partial and render (render takes just a view)

app/assets/javascripts/templates/application.handlebars:
``````
<div class="container" id="main">
  {{render navbar}}
  <div class="row">
    {{outlet}}
  </div>
</div>
`````

app/assets/javascripts/templates/navbar.handlebars:
````
<div class="navbar navbar-default">
  <div class="navbar-brand strong">{{#linkTo "index"}}Rails Ember Blog{{/linkTo}}</div>
  <ul class="nav navbar-nav navbar-left">
  </ul>
  <ul class="nav navbar-nav navbar-right">
  </ul>
</div>
````

➜  rails_ember_blog git:(w9d2-maloneyl) ✗ rails g scaffold post title content:text user:belongs_to
      invoke  active_record
      create    db/migrate/20131126135535_create_posts.rb
      create    app/models/post.rb
      invoke    test_unit
      create      test/unit/post_test.rb
      create      test/fixtures/posts.yml
      invoke  resource_route
       route    resources :posts
      create  app/serializers/post_serializer.rb
      invoke  ember:model
      create    app/assets/javascripts/models/post.js.coffee
      invoke  ember controller and view (singular)
      create    app/assets/javascripts/views/post_view.js.coffee
      invoke  ember controller and view (plural)
      create    app/assets/javascripts/views/posts_view.js.coffee
      invoke  scaffold_controller
      create    app/controllers/posts_controller.rb
      invoke    haml
      create      app/views/posts
      create      app/views/posts/index.html.haml
      create      app/views/posts/edit.html.haml
      create      app/views/posts/show.html.haml
      create      app/views/posts/new.html.haml
      create      app/views/posts/_form.html.haml
      invoke    test_unit
      create      test/functional/posts_controller_test.rb
      invoke    helper
      create      app/helpers/posts_helper.rb
      invoke      test_unit
      create        test/unit/helpers/posts_helper_test.rb
      invoke  scss
      create    app/assets/stylesheets/scaffolds.css.scss

which is really more stuff than we need now, so let's:
- delete the whole posts folder under views
- comment out the new and create methods in the posts_controller.rb

we also have a PostSerializer (app/serializers/post_serializer.rb) generated in the scaffold:
``````
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_one :user
end
``````
similar to our Post model, but acts like a filter to customize our JSON, e.g.
- make it so the JSON we send to API request will only include those attributes specified in PostSerializer
- send JSON to also include what's involved in the has_one relationship specified

app/assets/javascripts/models/post.js.coffee has been generated for us too:
``````
App.Post = DS.Model.extend
  title: DS.attr 'string'
  content: DS.attr 'string'
  user: DS.belongsTo 'App.User'
``````
but note that content is a special word in Ember, even though the scaffold doesn't stop us from doing that!
so we'll change "content" to "body" here on Emberber, even though in Rails we still have it as "content" -- we can resolve this later

if you nest a route, the child's view will be nested in the parent's view's outlet
e.g.
  routes: posts -> post
  views: posts.hbs {{outlet}} -> post.hbs

so we'll do that in router.js.coffee:
``````
App.Router.map ()->
  @resource 'posts', ->

    # get this nested URL: posts/:post_id
    # if the path is not defined, it'll be just: posts
    @resource 'post', path: '/:post_id' # :post_id is a dynamic segment, which will let us get a params object/"hash" and make the dynamic segment the value (just like in Rails)
``````

and when we need to match that with our route file, so we'll create both posts_route.js.coffee and post_route.js.coffee under routes

app/assets/javascripts/routes/posts_route.js.coffee:
`````
App.PostsRoute = Ember.Route.extend
  model: ->
    App.Post.find()
`````

app/assets/javascripts/routes/post_route.js.coffee:
``````
App.PostRoute = Ember.Route.extend
  model: (params) ->
    App.Post.find(params.post_id)
``````

note that this still won't work yet UNTIL we change our adapter (in store.js.coffee) from the _ams that we're forced upon to DS.RESTAdapter because of versioning reasons

we can use:
    {{#each model}}
          {{#link-to 'post' this}}
    {{/each}}
which is equivalent to:
    {{#each post in controller}}
          {{#link-to 'post' post}}
    {{/each}}

to see what our rails app is actually sending (the API from our rails):
  http://localhost:3000/posts.json
that still says the posts object contains content and user and no date

our "index" ("/") is currently controlled by an automatically generated IndexRoute, IndexController, etc.
we'd like to go to posts
the best way to do a redirection is in the Route file, so we'll create routes/index_route.js.coffee:
`````
App.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo('posts')
`````

our current blog posts don't have all info yet because of the content/body and date issues. so we can fix our serializer:
``````
class PostSerializer < ActiveModel::Serializer

  # specify what to ship in our API/JSON
  # includes the fields in our Post model by default - we can exclude any of those if we want to
  # and we can add more/change names as long as we write our own functions below
  attributes :id, :url, :title, :body, :date

  has_one :user # has_one or belongs_to is just has_one in Serializer
  # we'd send the info related to the user too

  # grab the URL of a post to then include as an attribute to send with our JSON
  def url
    post_url object # object is the current instance of the object being serialized
  end
  # we can see from http://localhost:3000/posts.json that 'url: "http://localhost:3000/posts/1"'

  # reminder: our Post model in Rails has content, vs. Ember's body
  def body
    object.content
  end

  # reminder: our Post model in Rails has created_at, vs. Ember's date
  def date
    # object.created_at # that would be a Date object
    object.created_at.getutc.iso8601 # standard format so that other programs can format however they want
  end

end
``````

before we do that has_one bit, we need a user model! which will be done by Devise:

➜  rails_ember_blog git:(w9d2-maloneyl) ✗ rails g devise:install
➜  rails_ember_blog git:(w9d2-maloneyl) ✗ rails g devise user
➜  rails_ember_blog git:(w9d2-maloneyl) ✗ rails g cancan:ability

and we'll update our devise:install migration file to add two custom fields:
      t.string :name
      t.boolean :admin # for cancan later

➜  rails_ember_blog git:(w9d2-maloneyl) ✗ rake db:migrate

and update the generated app/models/user.rb:
  attr_accessible :name
  has_many :posts

app/serializers/user_serializer.rb:
````````
````````

then do controllers/sessions_controller.rb (pasted code; and update the route to link to it) and controllers/application_controller.rb (pasted code)
update layouts/application.html.haml:
  // below is just a big string to Haml
  :javascript
    App.ready = function(){
      App.initApp(jQuery.parseJSON('#{current_user_json}'))
    }
update seed.rb
rake db:seed
check that it's all working in the console:
  u1, u2 = User.all
  u1.posts
  Post.first.user
create app/assets/javascripts/helpers/init_app.js.coffee (pasted code)
create app/assets/javascripts/controllers/auth_controller.js.coffee (where most of the client-server stuff is handled; pasted code)
create app/assets/javascripts/settings.js.coffee (pasted code)
create app/assets/javascripts/shortcuts.js.coffee (pasted code)

with those two new js files in the js root folder, we need to require them now. let's update app.js.coffee:
   #= require ./settings
   #= require ./shortcuts

create app/assets/javascripts/controllers/navbar_controller.js.coffee (pasted code)

update router with:
  @route 'login'
  @route 'registration'
and create those route object files (pasted code)

create app/assets/javacsripts/models/user.js.coffee

create app/assets/javascripts/templates/login.handlebars (pasted code)
create app/assets/javascripts/templates/registration.handlebars (pasted code)

update app/assets/javascripts/templates/navbar.handlebars to show these links

we can now login!

we'll take a turn and format things properly now
create app/assets/javascripts/helpers/handlebars_helpers.js.coffee:
`````
Ember.Handlebars.helper 'format-markdown', (input) -> # name of helper, (parameter)

  # initate it and stash it away
  window.showdown ?= new Showdown.converter() # we can do this because we have showdown.js loaded

  new Handlebars.SafeString(showdown.makeHtml(input)) # treat whatever output as safe (i.e. there's no script tag, can be rendered without need to escape anything)


Ember.Handlebars.helper 'format-date', (date) ->
  moment(date).fromNow() # we have moment.js loaded too and it's got a fromNow method
`````
