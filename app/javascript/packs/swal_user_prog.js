import swal from 'sweetalert2';

const swalConfirmButtonColor = '#DD0031';
const swalCancelButtonColor = '#2C365E';

const retryInterview = (() => {
  swal({
    title: 'Etes-vous sûr de vouloir recommencer le questionnaire ?',
    text: "Vos réponses précédentes seront effacées",
    type: 'warning',
    width: 500,
    showCancelButton: true,
    confirmButtonColor: swalConfirmButtonColor,
    cancelButtonColor: swalCancelButtonColor,
    confirmButtonText: 'Oui, je recommence!',
    cancelButtonText: 'Annuler' ,
  })
  .then((result) => {
    if (result.value) {
      document.getElementById("retry").click();
    }
  });
});

var retry = document.getElementById("retry-button")
retry.addEventListener("click", (retryInterview));
