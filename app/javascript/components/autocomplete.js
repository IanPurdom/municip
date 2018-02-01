function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var cityName = document.getElementById('wiki_city_name');
    var options = {
      types: ['(regions)'],
      componentRestrictions: {country:'fr'}
    };
    if (cityName) {
      var autocomplete = new google.maps.places.Autocomplete(cityName, options, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(cityName, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
