(function ($) {
  Drupal.behaviors.atl_move = {
    attach: function (context, settings) {

      var osmb = new OSMBuildings({
        // baseURL: './OSMBuildings',
        minZoom: 16,
        maxZoom: 19,
        position: { latitude: Drupal.settings.atl.coords.lat, longitude: Drupal.settings.atl.coords.lon },
        zoom: 19,
        tilt: 50,
        // state: true, // stores map position/rotation in url
        effects: ['shadows'],
        attribution: '© 3D <a href="https://osmbuildings.org/copyright/">OSM Buildings</a>',
        style: { color: 'rgb(220, 10, 200)' },
        fogColor: '#020202',
        backgroundColor: '#8800aa',
        highlightColor: '#88aa00'
      }).appendTo('map');

      osmb.addMapTiles(
        'https://{s}.tiles.mapbox.com/v3/osmbuildings.kbpalbpk/{z}/{x}/{y}.png',
        {
          attribution: '© Data <a href="https://openstreetmap.org/copyright/">OpenStreetMap</a>' +
            '· © Map <a href="https://mapbox.com/">Mapbox</a>'
        }
      );

      var QUEST_COLOR = '#ee00dd';
      var quests = Drupal.settings.atl.quests;

      // Highlight special buildings
      osmb.on('loadfeature', function(e) {
        var b = e.detail;
        var id = b.properties.relationId || b.id || b.properties.id;
        if (id in quests) {
          b.properties.color = QUEST_COLOR;
          b.properties.roofColor = QUEST_COLOR;
        }
      });

      osmb.addGeoJSONTiles('https://{s}.data.osmbuildings.org/0.2/anonymous/tile/{z}/{x}/{y}.json');

      //***************************************************************************

      osmb.on('pointermove', function(e) {
        var id = osmb.getTarget(e.detail.x, e.detail.y, function(id) {
          if (id) {
            document.body.style.cursor = 'pointer';
            osmb.highlight(id, '#eedd22');
          } else {
            document.body.style.cursor = 'default';
            osmb.highlight(null);
          }
        });
      });

      osmb.on('click', function(e) {
        var id = osmb.getTarget(e.offsetX, e.offsetY, function(id) {
          if (id) {
            document.body.style.cursor = 'pointer';
            osmb.highlight(id, '#00eedd');
            console.log(id);
            if (id in quests) {
              var pathname = window.location.pathname.split("/");
              // console.log(pathname);
              var href = window.location.origin + "/" + pathname[1] + "/quests/" + pathname[3] + "/" + quests[id];
              // console.log(href);
              window.location.href = href;
            }
          }
        });
      });


    }
  };
}(jQuery));
