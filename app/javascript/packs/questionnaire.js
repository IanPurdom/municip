import swal from 'sweetalert2';

const swalConfirmButtonColor = '#DD0031';
const swalCancelButtonColor = '#2C365E';

const deleteQuestion = ((clicked_id) => {
  console.log(clicked_id)
  swal({
    title: 'Etes-vous sûr de vouloir supprimer cette question ?',
    text: "Les réponses et le programme associé seront également supprimés",
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
      document.getElementById(`d-${clicked_id}`).click();
    }
  });
});

const addNextQuestion = ((clicked_id) => {
  var btnSelector = document.getElementById(`btn-${clicked_id}`);
  btnSelector.click()
});

const toggleQ = ((clicked_id) => {
  console.log(clicked_id)
  var class_array = clicked_id.split(" ")
  var clicked = class_array[0]
  document.querySelector(`.upd-${clicked}`).classList.add("hidden")
  document.querySelector(`.form-${clicked}`).classList.remove("hidden")
});

const toggleBlur = ((clicked_id) => {
  var class_array = clicked_id.split(" ")
  var clicked = class_array.slice(-1)[0]
  document.getElementById(`btn-${clicked}`).click()
  document.querySelector(`.upd-${clicked}`).classList.remove("hidden")
  document.querySelector(`.form-${clicked}`).classList.add("hidden")
});

window.deleteQuestion = deleteQuestion;
window.addNextQuestion = addNextQuestion;
window.toggleQ = toggleQ
window.toggleBlur = toggleBlur


