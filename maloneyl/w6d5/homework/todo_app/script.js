$(function(){

  // status: 0 = to-do, 1 = done
  // priority: 1-10
  window.item1 = new Item("Finish homework", 0, {priority: 9});
  window.item2 = new Item("Watch Gravity", 0);
  window.item3 = new Item("Call Mom", 1);
  window.item4 = new Item("Find ticket to The National gig", 1, {priority: 5})

  window.todos = [item1, item2, item3, item4];

  refreshFullList();

  function renderAll() {
    var templateString = $("#index").html();
    var values = {itemsToShow: todos};
    var rendered = _(templateString).template(values);
    $("#tab-all").html(rendered);
    $("#sort-by-priority").on("click", sortAllByPriority);
    $("[id$=status-checkbox]").on("click", updateItemStatus);
  };

  function renderDone() {
    var templateString = $("#index").html();
    var doneItems = _(todos).filter( function(t){ return t.status == 1 } );
    var values = {itemsToShow: doneItems};
    var rendered = _(templateString).template(values);
    $("#tab-done").html(rendered);
    $("[id$=status-checkbox]").on("click", updateItemStatus);
  };

  function renderTodo() {
    var templateString = $("#index").html();
    var todoItems = _(todos).filter( function(t){ return t.status == 0 } );
    var values = {itemsToShow: todoItems};
    var rendered = _(templateString).template(values);
    $("#tab-todo").html(rendered);
    $("[id$=status-checkbox]").on("click", updateItemStatus);
  };

  function refreshFullList() {
    renderAll();
    renderDone();
    renderTodo();
    renderAddNew();
  }

  function renderAddNew() {
    var templateString = $("#add-new-todo").html();
    var rendered = _(templateString).template();
    $("#tab-new").html(rendered);
    $("#new-todo-submit").on("click", createItem);
  };

  // avoid checkbox default "on"
  function setStatus(inputId) {
    if ($(inputId).is(":checked")) {
      return itemStatus = 1;
    } else {
      return itemStatus = 0;
    }
  }

  function createItem() {
    setStatus("#new-todo-status");
    var itemToAdd = new Item(
      $("#new-todo-description").val(),
      itemStatus,
      {priority: $("#new-todo-priority").val()}
    );
    todos.push(itemToAdd);
    alert("Item added!");
    refreshFullList();
  }

  // works in console...
  function updateItemStatus() {
    elem = event.target.id;
    indexInTodos = parseInt(elem);
    console.log("Triggered updateItemStatus", elem, indexInTodos);
    if ($("#"+elem).is(":checked")) {
      return todos[indexInTodos].status = 1;
    } else {
      return todos[indexInTodos].status = 0;
    }
    refreshFullList();
  }

  // 'all' sorted by priority (high first)
  function sortAllByPriority() {
    var itemsByPriority = _(todos).sortBy( function(t) { return -t.priority } );
    var values = {itemsToShow: itemsByPriority};
    var templateString = $("#index").html();
    var rendered = _(templateString).template(values);
    $("#tab-all").html(rendered);
    renderAll();
  }

});
