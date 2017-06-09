(function ($) {
  Drupal.behaviors.atl_move = {
    attach: function (context, settings) {

      var map = L.map('map',
        {
          minZoom: 12,
          maxZoom: 12
        }
        ).setView([Drupal.settings.atl.coords.lat, Drupal.settings.atl.coords.lon], 12);

      L.tileLayer('https://{s}.tiles.mapbox.com/v3/osmbuildings.kbpalbpk/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(map);

      var cloudIcon = L.icon({
        iconUrl: '/sites/all/modules/custom/atl/img/cloud.png',
        iconSize:     [60, 60], // size of the icon
        iconAnchor:   [30, 30], // point of the icon which will correspond to marker's location
        popupAnchor:  [0, 10] // point from which the popup should open relative to the iconAnchor
      });

      var markers = Drupal.settings.atl.markers;
      for (var i = 0, il = markers.length; i < il; i++) {
        L.marker([markers[i].lat, markers[i].lon], {icon: cloudIcon}).addTo(map)
          .bindPopup(markers[i].text);
          // .openPopup();
      }

      function onMapClick(e) {
        // console.log(e);
        var href = window.location.href.replace("/atl/map/", "/atl/move/") + "/" + e.latlng.lat + "/" + e.latlng.lng;
        // console.log(href);
        window.location.href = href;
      }

      map.on('click', onMapClick);

    }
  };
}(jQuery));
