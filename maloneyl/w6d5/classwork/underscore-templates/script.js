$(function(){
  template_string = $("#application").html(); // grab html of element id application
  values = {first_name: "Gerry", last_name: "Mathe"};
  rendered = _(template_string).template(values);
  $("#main").html(rendered);
})
