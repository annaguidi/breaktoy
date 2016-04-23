  var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var labelIndex = 0;
  var marker;
  var map;
  var url = window.location.href;
  var infowindow = null;

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
      center:new google.maps.LatLng(42.3601,-71.0589),
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

        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

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
          htmlBox.innerHTML = marker.label + '</br>' + marker.description +
          '</br>' + marker.id + '</br>'
          + "<a href='#' class='edit-btn' data-marker-id=' " + marker.id + " '>Edit</a>"
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
          google.maps.event.addListener(marker, 'click', (function (marker, i) {
            return function () {
              infowindow.setContent(container);
              console.log(marker.id);
              htmlBox.innerHTML = marker.label + '</br>' + marker.description +
              '</br>' + marker.id + '</br>'
              + "<a href='#' class='edit-btn' data-marker-description=' " +
              marker.description + " ' data-marker-title=' " + marker.label +
              " ' data-marker-id=' " + marker.id + " '>Edit</a>"
              infowindow.open(map, marker);
            }
          })(marker, i));
        };
      }
    });

    $(document).on('click', '.edit-btn', function loadEditForm() {
      var markerId = $(this).data("marker-id");
      var markerTitle = $(this).data("marker-title");
      var markerDescription = $(this).data("marker-description");
      htmlBox.innerHTML = "<form id='formoid' action='#'> Title: <br> <input id='title' type='text' name='title' value=' " + markerTitle + " '><br> Description:<br> <input type='text' id='description' name='description' value=' " + markerDescription + " '><br><br> <input type='submit' id='submitButton' data-submit-id=' " + markerId + " ' value='Submit'>" + "</form>"
    });

    $(document).on('click', '#submitButton', function editInfo() {
      event.preventDefault();
      var title = document.getElementById('title').value;
      var description = document.getElementById('description').value;
      var id = $(this).data("submit-id");

      htmlBox.innerHTML = title + '</br>' + description +
      '</br>' + id + '</br>'
      + "<a href='#' class='edit-btn' data-marker-id=' " + id + " '>Edit</a>"

      var request = $.ajax({
        method: "POST",
        url: "/groups/updatemarkers",
        data: { title: title, description: description, id: id }
      });
    });


    var submitMarkersViaAjax = function(latLng) {
      var request = $.ajax({
        method: "POST",
        url: "/markers",
        data: { latitude: latLng.lat(),
        longitude: latLng.lng(), group_id: group_id }
      });
    }
  }

  function addMarker(location, map) {
    // Add the marker at the clicked location, and add the next-available label
    // from the array of alphabetical characters.
    marker = new google.maps.Marker({
      position: location,
      label: labels[labelIndex++ % labels.length],
      map: map,
      clickable: true,
      draggable: true,
      info: "LALALALA",
      html: "You can edit the text of this infowindow"
    });

  }

  function createEditableMarker(options) {
    //(2) Create a marker normally.
    //Marker class accepts any properties even if it's not related with Marker.
    var marker = new google.maps.Marker(options);

    //(3)Set a flag property which stands for the editing mode.
    marker.set("editing", false);

    //(4)Create a div element to display the HTML strings.
    var htmlBox = document.createElement("div");
    htmlBox.innerHTML = options.html || "";
    htmlBox.style.width = "300px";
    htmlBox.style.height = "100px";

    //(5)Create a textarea for edit the HTML strings.
    var textBox = document.createElement("textarea");
    textBox.innerText = options.html || "";
    textBox.style.width = "300px";
    textBox.style.height = "100px";
    textBox.style.display = "none";

    //(6)Create a div element for container.
    var container = document.createElement("div");
    container.style.position = "relative";
    container.appendChild(htmlBox);
    container.appendChild(textBox);

    //(7)Create a button to switch the edit mode
    var editBtn = document.createElement("button");
    editBtn.innerText = "Edit";
    container.appendChild(editBtn);

    //(8)Create an info window
    var infoWnd = new google.maps.InfoWindow({
      content : container
    });

    var infoWnd = new google.maps.InfoWindow({
      content : container
    });

    //(9)The info window appear when the marker is clicked.
    google.maps.event.addListener(marker, "click", function() {
      debugger;
      infoWnd.open(marker.getMap(), marker);
    });

    //(10)Switch the mode. Since Boolean type for editing property,
    //the value can be change just negation.
    google.maps.event.addDomListener(editBtn, "click", function() {
      marker.set("editing", !marker.editing);
    });

    //(11)A (property)_changed event occur when the property is changed.
    google.maps.event.addListener(marker, "editing_changed", function(){
      textBox.style.display = this.editing ? "block" : "none";
      htmlBox.style.display = this.editing ? "none" : "block";
    });

    //(12)A change DOM event occur when the textarea is changed, then set the value into htmlBox.
    google.maps.event.addDomListener(textBox, "change", function(){
      htmlBox.innerHTML = textBox.value;
      marker.set("html", textBox.value);
    });
    return marker;
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
      html: "You can edit the text of this infowindow",
      description: data.description,
      id: data.id
    });
  }


  google.maps.event.addDomListener(window, 'load', initMap);
