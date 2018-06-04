import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';


function openCity(evt, cityName) {
  console.log(cityName)
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
  initMap();
};


function initMap() {
  const mapElement = document.getElementById('map');
  const markers = JSON.parse(mapElement.dataset.markers);
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: markers[0],
    mapTypeId: 'terrain'
  });

  //Define the LatLng coordinates for the polygon's path.
  const coordinates = JSON.parse(mapElement.dataset.coordinates)
  console.log(coordinates)
  var triangleCoords = coordinates;

  // Construct the polygon.
  var bermudaTriangle = new google.maps.Polygon({
    paths: triangleCoords,
    strokeColor: '#163F8A',
    strokeOpacity: 0.8,
    strokeWeight: 2,
    fillColor: '#88BBD9',
    fillOpacity: 0.35
  });
  bermudaTriangle.setMap(map);
};


// const mapElement = document.getElementById('map');
// if (mapElement) { initMap(mapElement);
//   };
// autocomplete();

window.openCity = openCity;

