$(function(){
  function request(){
    $.ajaxSetup({cache: false});
    var url = "https://api.github.com/search/repositories?q=rails";
    $.ajax({ // hash of parameters below:
      type: "GET",
      url: url,
      async: true, // true by default anyway; asyncronous means your page doesn't freeze when this loads
      jsonpCallback: "exec", // this returns a function called exec with usable json, not just a whole bunch of strings
      username: "maloneyl",
      password: "62b146a6cf60c6626808a2e6d1bcd132f82fc3c8", // that personal access token
      contentType: "application/json", // jQuery will try to figure out what it receives anyway, but good to have
      dataType: "jsonp", // must specify
      success: function(data){ // success means http status 200
        console.log(data)
      },
      error: function(){ // for when status is not 200...
        alert("Something went wrong...");
      }
    })
  }

  request();

});
