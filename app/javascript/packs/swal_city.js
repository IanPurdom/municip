import swal from 'sweetalert2';

const swalConfirmButtonColor = '#DD0031';
const swalCancelButtonColor = '#2C365E';

const deleteCity = (() => {
  swal({
    title: 'Etes-vous sûr de vouloir supprimer votre ville ?',
    text: "Les photos et les informations seront effacées",
    type: 'warning',
    width: 500,
    showCancelButton: true,
    confirmButtonColor: swalConfirmButtonColor,
    cancelButtonColor: swalCancelButtonColor,
    confirmButtonText: 'Oui, je supprime!',
    cancelButtonText: 'Annuler' ,
  })
  .then((result) => {
    if (result.value) {
      document.getElementById("delete-city").click();
    }
  });
});


// !!!!  move to questionnaire.js


// const deleteCityPhoto = ((clicked_id) => {
//   swal({
//     title: 'Etes-vous sûr de vouloir supprimer cette photo ?',
//     type: 'warning',
//     width: 500,
//     showCancelButton: true,
//     confirmButtonColor: swalConfirmButtonColor,
//     cancelButtonColor: swalCancelButtonColor,
//     confirmButtonText: 'Oui, je supprime!',
//     cancelButtonText: 'Annuler' ,
//   })
//   .then((result) => {
//     if (result.value) {
//       document.getElementById(`delete-${clicked_id}`).click();
//     }
//   });
// });

var retry = document.getElementById("delete-city-button");
retry.addEventListener("click", (deleteCity));

var photos = document.getElementsByClassName("delete-city-photo-button");
var photos2 = document.getElementsByClassName("delete-city-photo");
for (var i = 0; i < photos.length; i++) {
  photos[i].id = `button${i}`;
  photos2[i].id = `delete-button${i}`;
}


// window.deleteCityPhoto = deleteCityPhoto;
