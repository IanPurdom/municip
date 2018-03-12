const addNextQuestion = ((clicked_id) => {
  console.log(clicked_id)
  var btnSelector = document.getElementById(`btn-${clicked_id}`);
  console.log(btnSelector.id)
  btnSelector.click()
});

const toggleQ = ((clicked_id) => {
  document.querySelector(`.upd-${clicked_id}`).classList.add("hidden")
  document.querySelector(`.form-${clicked_id}`).classList.remove("hidden")
});

const toggleBlur = ((clicked_id) => {
  console.log(clicked_id)
  document.getElementById(`btn-${clicked_id}`).click()
  document.querySelector(`.upd-${clicked_id}`).classList.remove("hidden")
  document.querySelector(`.form-${clicked_id}`).classList.add("hidden")
});


const toggleQAns = ((clicked_id) => {
  document.querySelector(`.upd-${clicked_id}`).classList.add("hidden")
  document.querySelector(`.form-${clicked_id}`).classList.remove("hidden")
});

const toggleBlurAns = ((clicked_id) => {
  console.log(clicked_id)
  document.getElementById(`btn-${clicked_id}`).click()
  document.querySelector(`.upd-${clicked_id}`).classList.remove("hidden")
  document.querySelector(`.form-${clicked_id}`).classList.add("hidden")
});



window.toggleQAns = toggleQAns
window.toggleBlurAns = toggleBlurAns
window.addNextQuestion = addNextQuestion;
window.toggleQ = toggleQ
window.toggleBlur = toggleBlur
