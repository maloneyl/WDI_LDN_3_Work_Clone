$(function(){

  var ctx = document.getElementById("myChart").getContext("2d"); //ctx means context

  function draw_chart(data){
    var data_for_chart = {
      labels : _(data).pluck("quarter"), //ALWAYS use underscore to get values of a single column! simplest.
      datasets : [
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(220,220,220,1)",
          pointColor : "rgba(220,220,220,1)",
          pointStrokeColor : "#fff",
          data : _(data).pluck("qoq_growth")
        }
      ]
    }
    new Chart(ctx).Line(data_for_chart);
  }

  // each time this function is called, the data gets refresh even when the page itself doesn't
  function call_api(offset){
    $.getJSON("/gdps.json", {offset: offset}, function(data){ //returns an array of those objects
      draw_chart(data);
      $.each(data, function(index, gdp){ //index is the loop index
        $("#gdp_list").append("<li>" + gdp.quarter + " -- " + gdp.qoq_growth + "</li>");
      })
    })
  }

  $("#offset_select").on("change", function(){
    call_api($(this).val()); // $(this).val() returns current value of dropdown
  })

  call_api(0); // offset 0 as default view
  // we'll see in our rails console that:
  // Started GET "/rates.json?offset=0" for 127.0.0.1 at 2013-11-12 10:24:22 +0000
  // Processing by RatesController#index as JSON
  // Parameters: {"offset"=>"0"}

})
