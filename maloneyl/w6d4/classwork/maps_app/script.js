$(function() {

  // GOOGLE MAPS

  var mapOptions = {
    zoom: 8, // possible range: 0-20
    center: new google.maps.LatLng(51.508, -0.120), // method instantiating new object
    mapTypeId: google.maps.MapTypeId.ROADMAP // property, not method
  }
  canvas = document.getElementById("googleMap"); // this returns an object that's different from just doing $("googleMap")
  map = new google.maps.Map(canvas, mapOptions);

  function updateLocation(position) {
    var coords = position.coords;
    var latlng = new google.maps.LatLng(coords.latitude, coords.longitude);
    var marker = new google.maps.Marker({
      position: latlng,
      map: map
    });
    map.setCenter(latlng);
    map.setZoom(17);
  }

  function handleErrorLocation(error) {
    console.log(error);
  }

  // geolocation api is also using google... your browser sends stuff to google to locate you
  $("#current_position").on("click", function(){
    if(navigator.geolocation){ // navigator is the native object referring to the browser; old browsers don't support geolocation
      navigator.geolocation.getCurrentPosition(updateLocation, handleErrorLocation);
      navigator.geolocation.watchPosition(updateLocation, handleErrorLocation); // this means update position as you move around
    } else {
      alert("I leave you in the 90s");
    }
  })

  // autocomplete api
  var infoWindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map // attach marker to map, no position until later when we have an autocomplete place selected
  });

  var input = document.getElementById("autocomplete");
  var autocomplete = new google.maps.places.Autocomplete(input);

  autocomplete.bindTo("bounds", map);

  google.maps.event.addListener(autocomplete, "place_changed", function(){
    var place = autocomplete.getPlace();
    marker.setVisible(false);
    infoWindow.close(); // in case there's already one opened

    // move the map
    if(place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport); // automatically update map's boundaries, center, zoom
    } else {  // otherwise, do the above manually
      map.setCenter(place.geometry.location);
      map.setZoom(17);
    }

    // display a point
    marker.setIcon({ // change marker from default Google Place one
      url: place.icon
    });
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    // customize info to display
    var address = "";
    if(place.address_components) { // verify that address_components exists within place
      address = (place.address_components[0] && place.address_components[0].short_name || "") // verify that [0] (usually the city) exists and get the short_name if so; otherwise, return empty string
    }
    infoWindow.setContent("<div>" + place.name + "</div><br />" + address);
    infoWindow.open(map, marker);
  });

  // directions
  $("#directions_form").on("submit", function(){

    // grab values from our form
    from = $("#directions_from").val();
    to = $("#directions_to").val();
    mode = $("#directions_mode").val();

    // put together that google map request from our values
    var request = {
      origin: from,
      destination: to,
      travelMode: google.maps.TravelMode[mode]
    }

    directionsService = new google.maps.DirectionsService();
    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsDisplay.setMap(map);
    directionsService.route(request, function(response, status){ // status refers to 200 for OK in http, etc.
      if(status == google.maps.DirectionsStatus.OK) { // google has its own status code
        directionsDisplay.setDirections(response); // response is the directions from google
        $("directions-panel").html("");
        directionsDisplay.setPanel(document.getElementById("directions-panel"));
      } else {
        alert("Something went wrong");
      }
    });
    return false; // i.e. don't submit the form
  })

})
