var group_id = $("#data-group-id").data("group-id");
function initScroll() {
  $.ajax({
    type: 'GET',
    url: '/groups/markers',
    dataType: 'json',
    data: {group_id: group_id},
    success: function(response) {
      var scrollbar = $(document.getElementById("marker-sidebar"));
      for (var i = response.length - 1; i > 0; i--) {
        scrollbar.append('<p>' + response[i].title + '</p>');
      }
    }
  });
}

google.maps.event.addDomListener(window, 'load', initScroll);
