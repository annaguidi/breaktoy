  var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var labelIndex = 0;
  var marker;
  var service;
  var map;
  var url = window.location.href;
  var infowindow = null;
  var longitude_coord = $("#data-group-longitude").data("group-longitude");
  var latitude_coord = $("#data-group-latitude").data("group-latitude");

  var htmlBox = document.createElement("div");
  htmlBox.innerHTML = "";
  htmlBox.style.width = "300px";
  htmlBox.style.height = "100px";

  //(5)Create a textarea for edit the HTML strings.
  var textBox = document.createElement("textarea");
  textBox.innerText = "";
  textBox.style.width = "300px";
  textBox.style.height = "100px";
  textBox.style.display = "none";

  //(6)Create a div element for container.
  var container = document.createElement("div");
  container.style.position = "relative";
  container.appendChild(htmlBox);
  container.appendChild(textBox);

  function initMap() {
    var mapProp = {
      center:new google.maps.LatLng(latitude_coord,longitude_coord),
      zoom:12
    };

    map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

    var contentwindow = '<div>your point</div>'
    infowindow = new google.maps.InfoWindow({
      content: ''
    });


    var input = document.getElementById('pac-input');
    var searchBox = new google.maps.places.SearchBox(input);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    map.addListener('bounds_changed', function() {
      searchBox.setBounds(map.getBounds());
    });

    var markers = [];

    searchBox.addListener('places_changed', function() {
      var places = searchBox.getPlaces();

      if (places.length == 0) {
        return;
      }

      //maybe add code here
      markers.forEach(function(marker) {
        marker.setMap(null);
      });
      markers = [];

      var bounds = new google.maps.LatLngBounds();
      places.forEach(function(place) {
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };


        markers.push(marker = new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));
        google.maps.event.addListener(marker, 'click', (function (marker) {
          return function () {
            infowindow.setContent(container);
            console.log(marker.id);
            htmlBox.innerHTML = "<form id='formoid' action='#'> Title: <br> <input id='title' type='text' name='title' value='Title: '><br> Description:<br> <input type='text' id='description' name='description' value='Description: '><br><br> <input type='submit' id='submitButton' data-submit-id=' " + marker.id + " ' value='Submit'>" + "</form>"
            infowindow.open(map, marker);
          }
        })(marker));
        submitMarkersViaAjax(place.geometry.location);

        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }
      });
      map.fitBounds(bounds);
    });


    google.maps.event.addListener(map, 'click', function(event) {
      addMarker(event.latLng, map);
      google.maps.event.addListener(marker, 'click', (function (marker) {
        return function () {
          infowindow.setContent(container);
          console.log(marker.id);
          htmlBox.innerHTML = "<form id='formoid' action='#'> Title: <br> <input id='title' type='text' name='title' value='Title: '><br> Description:<br> <input type='text' id='description' name='description' value='Description: '><br><br> <input type='submit' id='submitButton' data-submit-id=' " + marker.id + " ' value='Submit'>" + "</form>"
          infowindow.open(map, marker);
        }
      })(marker));
      submitMarkersViaAjax(event.latLng);
    });

    var group_id = $("#data-group-id").data("group-id");
    $.ajax({
      type: 'GET',
      url: '/groups/markers',
      dataType: 'json',
      data: {group_id: group_id},
      success: function(response) {
        for (var i = 0; i < response.length; i++) {
          addMarkerByLatLng(response[i], map);
          google.maps.event.addListener(marker, 'click', (function (clickedMarker, i) {
            return function () {
              marker = clickedMarker;
              infowindow.setContent(container);
              console.log(clickedMarker.id);
              htmlBox.innerHTML = clickedMarker.label + '</br>' + clickedMarker.description +
              '</br>' + clickedMarker.user + '</br>'
              + "<a href='#' class='edit-btn' data-marker-description=' " +
              clickedMarker.description + " ' data-marker-title=' " + clickedMarker.label +
              " ' data-marker-id=' " + clickedMarker.id + " '>Edit</a> <br> <a href='#' class='dlt-btn'>Delete</a>"
              infowindow.open(map, clickedMarker);
            }
          })(marker, i));
        };
      }
    });

    $(document).on('click', '.dlt-btn', function deleteContent() {
      var id = marker.id;
      var request = $.ajax({
        method: "POST",
        url: "/groups/deletemarker",
        data: { id: id },
        success: function(response) {
        },
        error: function(response){
        }
      });
      marker.setMap(null);
    });

    $(document).on('click', '.edit-btn', function loadEditForm() {
      var markerId = marker.id;
      var markerTitle = marker.label;
      var markerDescription = marker.description;
      var markerUser = marker.user;
      htmlBox.innerHTML = "<form id='formoid' action='#'> Title: <br> <input id='title' type='text' name='title' value=' " + markerTitle + " '><br> Description:<br> <input type='text' id='description' name='description' value=' " + markerDescription + " '><br><br> <input type='submit' id='submitButton' data-submit-id=' " + markerId + " ' value='Submit'>" + "</form>"
    });

    $(document).on('click', '#submitButton', function editInfo() {
      event.preventDefault();
      var title = document.getElementById('title').value;
      var description = document.getElementById('description').value;
      var id = $(this).data("submit-id");

      htmlBox.innerHTML = title + '</br>' + description +
      '</br>' + marker.user + '</br>'
      + "<a href='#' class='edit-btn' data-marker-id=' " + id + " '>Edit</a> <br> <a href='#' class='dlt-btn'>Delete</a>"

      var request = $.ajax({
        method: "POST",
        url: "/groups/updatemarkers",
        data: { title: title, description: description, id: id },
        success: function(response) {
          marker.id = response.id;
          marker.label = response.title;
          marker.description = response.description;
        }
      });
      google.maps.event.addListener(marker, 'click', (function (clickedMarker) {
        return function () {
          marker = clickedMarker;
          infowindow.setContent(container);
          console.log(clickedMarker.id);
          htmlBox.innerHTML = clickedMarker.label + '</br>' + clickedMarker.description +
          '</br>' + clickedMarker.user + '</br>'
          + "<a href='#' class='edit-btn' data-marker-description=' " +
          clickedMarker.description + " ' data-marker-title=' " + clickedMarker.label +
          " ' data-marker-id=' " + clickedMarker.id + " '>Edit</a> <br> <a href='#' class='dlt-btn'>Delete</a>"
          infowindow.open(map, clickedMarker);
        }
      })(marker));

    });


    var submitMarkersViaAjax = function(latLng) {
      var request = $.ajax({
        method: "POST",
        url: "/markers",
        data: { latitude: latLng.lat(),
        longitude: latLng.lng(), group_id: group_id },
        success: function(response) {
          marker.id = response.id;
          marker.user = response.user;
        }
      });
    }
  }

  var fx = google.maps.InfoWindow.prototype.setPosition;
  //override the built-in setPosition-method
  google.maps.InfoWindow.prototype.setPosition = function () {
    //logAsInternal isn't documented, but as it seems
    //it's only defined for InfoWindows opened on POI's
    if (this.logAsInternal) {
      google.maps.event.addListenerOnce(this, 'map_changed',function () {
        var map = this.getMap();
        //the infoWindow will be opened, usually after a click on a POI
        if (map) {
          //trigger the click
          google.maps.event.trigger(map, 'click', {latLng: this.getPosition()});
        }
      });
    }
    fx.apply(this, arguments);
  };

  function addMarker(location, map) {
    // Add the marker at the clicked location, and add the next-available label
    // from the array of alphabetical characters.
    marker = new google.maps.Marker({
      position: location,
      label: labels[labelIndex++ % labels.length],
      map: map,
      clickable: true,
      draggable: true
    });

    marker.addListener('dragend',function(event) {
      var latitudine = event.latLng.lat();
      var longitudine = event.latLng.lng();
      var id = marker.id
      var request = $.ajax({
        method: "POST",
        url: "/groups/updatemarkerposition",
        data: { latitude: latitudine, longitude: longitudine, id: id },
        success: function(response) {
          marker.id = response.id;
          marker.position = {lat: response.latitude, lng: response.longitude};
        }
      });
    });
  }


  var addMarkerByLatLng = function(data, map) {
    // Add the marker at the clicked location, and add the next-available label
    // from the array of alphabetical characters.
    marker = new google.maps.Marker({
      position: {lat: data.latitude, lng: data.longitude},
      label: data.title,
      map: map,
      clickable: true,
      draggable: true,
      description: data.description,
      id: data.id,
      user: data.user
    });

    marker.addListener('dragend',function(event) {
      var latitudine = event.latLng.lat();
      var longitudine = event.latLng.lng();
      var id = marker.id
      var request = $.ajax({
        method: "POST",
        url: "/groups/updatemarkerposition",
        data: { latitude: latitudine, longitude: longitudine, id: id },
        success: function(response) {
          marker.id = response.id;
          marker.position = {lat: response.latitude, lng: response.longitude};
        }
      });
    });
  }


  google.maps.event.addDomListener(window, 'load', initMap);
