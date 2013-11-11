// create object in a separate file from script.js

function Todo(items){

  var self = this;

  self.items = items;
  self.values = null; // they will be passed through the 'items' passed in when creating a new Todo
  self.mode = "all"; // default value we want when we initialize
  self.status = { "todo": 0, "done": 1 }; // we use "todo"/"done" in our html and 0/1 in our items

  // our top looks like: "All (10), Done (2), To-Do (8)"
  self.$top_container = $("#top");
  self.$top_template = $("#top_template").html();

  self.$main_container = $("#container");
  self.$main_template = $("#application").html();

  function set_values(){
    if(self.mode == "all")
      var items = self.items;
    else // self.mode == "todo" or "done" (which are the keys on self.status)
      var items = _(self.items).filter(function(item){ return item.status == self.status[self.mode] }); // item.status returns a value of self.status

    self.values = {
      total_count: self.items.length, // reminder: self.items is an array
      done_count: _(self.items).where({status: 1}).length,
      todo_count: _(self.items).where({status: 0}).length,
      items: items
    }
  }

  function list(type) {
    self.mode = type; // i.e. go from default "all" to "done", "todo" or still "all"
    render();
  }

  function change_status() {
    var id = $(this).data("id"); // 'this' is the checkbox itself because this function came from $(".status").on("change"); and data("id") refers to "data-id" attribute in our html
    var status = $(this).is(":checked") ? 1 : 0 // :checked is a css selector too; if checked, set status to 1... else 0

    // map our existing items array for the item to change
    self.items = _(self.items).map(function(item){
      if(item.id == id) item.status = status;
      return item;
    })

    // refresh tabs to show new counts
    list(self.mode); // because mode (all/todo/done) doesn't change regardless of what you're doing there
  }

  function add_todo(){
    self.items.push({
      id: (self.items.length + 1),
      title: $("#todo_title_input").val(),
      status: 0
    });
    render();
  }

  function render(){
    set_values(); // update every time before loading the view
    self.$main_container.html(_(self.$main_template).template(self.values)); // through self.values we now have items
    self.$top_container.html(_(self.$top_template).template(self.values));

    $(".list_link").on("click", function(){ list( $(this).data("type") ) }); // 'this' refers to the click-associated <a> tag; .data('type') refers to data-type

    $(".status").on("change", change_status);

    $("#add_todo").on("click", add_todo);
  }

  function initialize(){
    render();
    // BTW, if we call 'this' here, it will be the 'this' in this function,
    // not the same as 'self'/'this' in the Todo function
  }

  initialize();

}
