import swal from 'sweetalert2';

const swalConfirmButtonColor = '#DD0031';
const swalCancelButtonColor = '#2C365E';

const deleteDeputy = ((clicked_id) => {
  console.log(clicked_id)
  swal({
    title: 'Etes-vous sûr de vouloir supprimer cet adjoint ?',
    text: "Toutes ses informations seront effacées",
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
      document.getElementById(`delete-${clicked_id}`).click();
    }
  });
});

var deputies = document.getElementsByClassName("delete-deputy-button")
var deputies2 = document.getElementsByClassName("delete-deputy")
for (var i = 0; i < deputies.length; i++) {
  deputies[i].id = `button${i}`;
  deputies2[i].id = `delete-button${i}`;
};

window.deleteDeputy = deleteDeputy
