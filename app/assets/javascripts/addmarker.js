  var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var labelIndex = 0;
  var marker;
  var map;
  var url = window.location.href

  function initMap() {
    var mapProp = {
      center:new google.maps.LatLng(42.3601,-71.0589),
      zoom:12
    };
    map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

    google.maps.event.addListener(map, 'click', function(event) {
      addMarker(event.latLng, map);
      submitMarkersViaAjax(event.latLng);
    });

    $.ajax({
      type: 'GET',
      url: '/groups/markers',
      dataType: 'json',
      data: {url: url},
      success: function(response) {
        for (var i = 0; i < response.length; i++) {
          addMarkerByLatLng(response[i].title, response[i].latitude, response[i].longitude, map);
        };
      }
    });

    var submitMarkersViaAjax = function(latLng) {
      var request = $.ajax({
        method: "POST",
        url: "/markers",
        data: { latitude: latLng.lat(),
        longitude: latLng.lng(), url: url }
      });
    }
  }

  function addMarker(location, map) {
    // Add the marker at the clicked location, and add the next-available label
    // from the array of alphabetical characters.
    marker = new google.maps.Marker({
      position: location,
      label: labels[labelIndex++ % labels.length],
      map: map
    });
  }

  var addMarkerByLatLng = function(label,lat, lng, map) {
    // Add the marker at the clicked location, and add the next-available label
    // from the array of alphabetical characters.
    marker = new google.maps.Marker({
      position: {lat: lat, lng: lng},
      label: label,
      map: map
    });
  }

  google.maps.event.addDomListener(window, 'load', initMap);
