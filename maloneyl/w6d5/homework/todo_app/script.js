$(function(){

  // status: 0 = to-do, 1 = done
  // priority: 1-10
  window.item1 = new Item("Finish homework", 0, {priority: 9});
  window.item2 = new Item("Watch Gravity", 0);
  window.item3 = new Item("Call Mom", 1);
  window.item4 = new Item("Find ticket to The National gig", 1, {priority: 5})

  window.todos = [item1, item2, item3, item4, item5];

  refreshFullList();

  function renderAll() {
    templateString = $("#index").html();
    values = {itemsToShow: todos};
    rendered = _(templateString).template(values);
    $("#tab-all").html(rendered);
  };

  function renderDone() {
    templateString = $("#index").html();
    doneItems = _(todos).filter( function(t){ return t.status == 1 } );
    values = {itemsToShow: doneItems};
    rendered = _(templateString).template(values);
    $("#tab-done").html(rendered);
  };

  function renderTodo() {
    templateString = $("#index").html();
    todoItems = _(todos).filter( function(t){ return t.status == 0 } );
    values = {itemsToShow: todoItems};
    rendered = _(templateString).template(values);
    $("#tab-todo").html(rendered);
  };

  function refreshFullList() {
    renderAll();
    renderDone();
    renderTodo();
    renderAddNew();
  }

  function renderAddNew() {
    templateString = $("#application").html();
    rendered = _(templateString).template();
    $("#tab-new").html(rendered);
    $("#new-todo-submit").on("click", createItem);
  };

  function setStatus(id) {
    if ($(id).is(":checked")) {
      return itemStatus = 1;
    } else {
      return itemStatus = 0;
    }
  }

  function createItem() {
    setStatus("#new-todo-status");
    itemToAdd = new Item(
      $("#new-todo-description").val(),
      itemStatus,
      {priority: $("#new-todo-priority").val()}
    );
    todos.push(itemToAdd);
    alert("Item added!");
    refreshFullList();
  }

  function updateItemStatus() {

  };

});


