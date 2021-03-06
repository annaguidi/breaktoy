<script type='text/javascript'>

  var mapCanvas;
  function initialize() {
    var mapDiv = document.getElementById("map_canvas");
    mapCanvas = new google.maps.Map(mapDiv, {
      center : new google.maps.LatLng(40.803, -74.097),
      zoom : 10,
      mapTypeId : google.maps.MapTypeId.ROADMAP
    });

    //(1)Set the HTML strings as html property.
    var marker = createEditableMarker({
      position : mapCanvas.getCenter(),
      html : "You can edit the text of this infowindow",
      map : mapCanvas
    });

    //(13)A html_changed event occur when the html property is changed.
    google.maps.event.addListener(marker, "html_changed", function(){
      console.log(this.html);
    });

    //Dispatch a click event.
    setTimeout(function() {
      google.maps.event.trigger(marker, "click");
    }, 2000);
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

    //(9)The info window appear when the marker is clicked.
    google.maps.event.addListener(marker, "click", function() {
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
  google.maps.event.addDomListener(window, "load", initialize);
    </script>
