import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';


function openCity(id) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
  }
  var tab = document.getElementsByClassName("tab");
  console.log(tab)
  for (i = 0; i < tab.length; i++) {
      tab[i].classList.remove("active");
  }
  document.getElementById("city-tabcontent").style.display = "block";
  document.getElementById("city-tab").classList.add("active")
  initMap();
};

function initMap() {
  const mapElement = document.getElementById('map');
  const markers = JSON.parse(mapElement.dataset.markers);
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
    strokeColor: '#163F8A',
    strokeOpacity: 0.8,
    strokeWeight: 2,
    fillColor: '#88BBD9',
    fillOpacity: 0.35
  });
  bermudaTriangle.setMap(map);
};

// var tabs = document.querySelector(".tabs");
// var tab = document.getElementsByClassName("tab");

// for (var i=0; i < tab.length; i++){
//   tab[i].addEventListener("click", function() {
//     var active = document.getElementsByClassName("active");
//     console.log(active);
//     for (var j=0; j < active.length;j++){
//     console.log(active[j])
//     active[j].classList.remove("active");
//     }
//     this.className += " active"
//   });
// };

window.openCity = openCity;

