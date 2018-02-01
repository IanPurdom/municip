import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

// function initMap() {
//   const mapElement = document.getElementById('map');
//   const markers = JSON.parse(mapElement.dataset.markers)
//   var map = new google.maps.Map(mapElement, {
//     zoom: 11,
//     center: markers[0]
//   });
// }

// google.maps.event.addDomListener(window, 'load', initMap);


function initMap(mapElement) {
  // const mapElement = document.getElementById('map');
  const markers = JSON.parse(mapElement.dataset.markers)
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: markers[0],
    mapTypeId: 'terrain'
  });

  //Define the LatLng coordinates for the polygon's path.
  const coordinates = JSON.parse(mapElement.dataset.coordinates)
  var triangleCoords = coordinates;

  // Construct the polygon.
  var bermudaTriangle = new google.maps.Polygon({
    paths: triangleCoords,
    strokeColor: '#FF0000',
    strokeOpacity: 0.8,
    strokeWeight: 2,
    fillColor: '#FF0000',
    fillOpacity: 0.35
  });
  bermudaTriangle.setMap(map);
};



const mapElement = document.getElementById('map');
if (mapElement) { initMap(mapElement);
  };

autocomplete();

