
function slidePane(pane) {
  setTimeout(
      function() {
    ( pane.style.width == '50px' || pane.style.width == '' )
        ? pane.style.width = '750px'
        : pane.style.width = '50px';
      }, 2000);
};


var pane = document.getElementById( 'slide' )
document.addEventListener("DOMContentLoaded", (slidePane(pane)));

pane.addEventListener( 'click', function() {

    ( this.style.width == '50px' || this.style.width == '' )
        ? this.style.width = '750px'
        : this.style.width = '50px';

}, false );


