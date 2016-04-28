var group_id = $("#data-group-id").data("group-id");

function initScroll() {
  $.ajax({
    type: 'GET',
    url: '/groups/markers',
    dataType: 'json',
    data: {group_id: group_id},
    success: function(response) {
      var scrollbar = $(document.getElementById("marker-sidebar"));
      for (var i = response.length - 1; i >= 0; i--) {
        scrollbar.append("<a href='#' class='link-btn' data-marker-latitude='" +
        response[i].latitude + "' + data-marker-longitude='" +
        response[i].longitude + "'>" + response[i].title + "</a><br>" +
        "- " + response[i].user + "<br><br>");
      }
    }
  });
}

$(document).on('click', '.link-btn', function PanOnMarker() {
  var longitude = $(this).data("marker-longitude");
  var latitude = $(this).data("marker-latitude");

  map.setCenter(new google.maps.LatLng(latitude, longitude));
  map.setZoom(18);
});

google.maps.event.addDomListener(window, 'load', initScroll);
