$(function(){

  var ctx = document.getElementById("myChart").getContext("2d"); //ctx means context

  function draw_chart(data){
    var data_for_chart = {
      labels : _(data).pluck("date_value"), //ALWAYS use underscore to get values of a single column! simplest.
      datasets : [
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(220,220,220,1)",
          pointColor : "rgba(220,220,220,1)",
          pointStrokeColor : "#fff",
          data : _(data).pluck("usd")
        },
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(220,220,220,1)",
          pointColor : "green",
          pointStrokeColor : "#fff",
          data : _(data).pluck("gbp")
        }
      ]
    }
    new Chart(ctx).Line(data_for_chart); //we remove option as the 2nd arg for Line cuz we don't need it
  }

  // each time this function is called, the data gets refresh even when the page itself doesn't
  function call_api(offset){
    $.getJSON("/rates.json", {offset: offset}, function(data){ //returns an array of those objects
      // data = data.slice(0, 100); // vanilla js; we're only plotting the first 100 elements in our 1200px-wide plot
      // ^-- no longer necessary because we moved it to our rates_controller.rb
      draw_chart(data);
      $.each(data, function(index, rate){ //index is the loop index
        $("#rates_list").append("<li>" + rate.date_value + " -- " + rate.usd + "</li>");
      })
    })
  }

  // // all code below came from chart.js documentation
  // // below will get us a nice line chart (with dummy data in the code)
  // // we'll start here just to test the chart
  // var ctx = document.getElementById("myChart").getContext("2d"); //ctx means context
  // var data = {
  //   labels : ["January","February","March","April","May","June","July"],
  //   datasets : [
  //     {
  //       fillColor : "rgba(220,220,220,0.5)",
  //       strokeColor : "rgba(220,220,220,1)",
  //       pointColor : "rgba(220,220,220,1)",
  //       pointStrokeColor : "#fff",
  //       data : [65,59,90,81,56,55,40]
  //     },
  //     {
  //       fillColor : "rgba(151,187,205,0.5)",
  //       strokeColor : "rgba(151,187,205,1)",
  //       pointColor : "rgba(151,187,205,1)",
  //       pointStrokeColor : "#fff",
  //       data : [28,48,40,19,96,27,100]
  //     }
  //   ]
  // }
  // new Chart(ctx).Line(data); //we remove option as the 2nd arg for Line cuz we don't need it

  $("#offset_select").on("change", function(){
    call_api($(this).val()); // $(this).val() returns current value of dropdown
  })

  call_api(0); // offset 0 as default view
  // we'll see in our rails console that:
  // Started GET "/rates.json?offset=0" for 127.0.0.1 at 2013-11-12 10:24:22 +0000
  // Processing by RatesController#index as JSON
  // Parameters: {"offset"=>"0"}

})
