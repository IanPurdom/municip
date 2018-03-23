import swal from 'sweetalert2';

const swalConfirmButtonColor = '#DD0031';
const swalCancelButtonColor = '#2C365E';

const deleteQuestionnaire = ((clicked_id) => {
  console.log(clicked_id)
  swal({
    title: 'Etes-vous sûr de vouloir supprimer ce questionnaire ?',
    text: "Les questions, réponses et les programme associés seront également supprimés!",
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



const deleteQuestion = ((clicked_id) => {
  console.log(clicked_id)
  swal({
    title: 'Etes-vous sûr de vouloir supprimer cette question ?',
    text: "Les réponses et le programme associés seront également supprimés",
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


const deleteAnswer = ((clicked_id) => {
  console.log(clicked_id)
  swal({
    title: 'Etes-vous sûr de vouloir supprimer cette réponse ?',
    text: "Le programme associé sera également supprimés",
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
  var clicked = class_array.slice(-1)[0]
  document.querySelector(`.upd-${clicked}`).classList.add("hidden")
  document.querySelector(`.form-${clicked}`).classList.remove("hidden")
});

const toggleBlur = ((clicked_id) => {
  var class_array = clicked_id.split(" ")
  var clicked = class_array.slice(-1)[0]
  console.log(clicked)
  document.getElementById(`btn-${clicked}`).click()
  document.querySelector(`.form-${clicked}`).classList.add("hidden")
  document.querySelector(`.upd-${clicked}`).classList.remove("hidden")
});

// only for question form created by JS
const toggleBlurNewQ = ((clicked_id) => {
  var class_array = clicked_id.split(" ")
  var clicked = class_array.slice(-1)[0]
  console.log(clicked)
  document.getElementById(`btn-${clicked}`).click()
});


const addQuestionForm = (()=> {

  var jsArea = document.getElementById("js-area");
  var newQ = document.createElement("div");
  setAttributes(newQ, {"id": "question", "class": "tab-question"});
  var form = document.createElement("form");
  var questionnaire_id = document.getElementById("questionnaire").dataset.questionnaire_id
  console.log(questionnaire_id)
  setAttributes(form, {"novalidate": "novalidate","id":"new_question", "class": "simple_form new_question form-q", "action": `/questionnaires/${questionnaire_id}/questions`, "accept-charset":"UTF-8", "data-remote": "true", "method": "post"})
  var input1 = document.createElement("input");
  setAttributes(input1, {"name":"utf8", "type": "hidden", "value": "✓"});
  // to be check later
  // var input3 = document.createElement("input");
  // setAttributes(input3, {"name":"authenticity_token", "type": "hidden", "value": "{$('meta[name=csrf-token]').attr('content')}/>"})
  var div =  document.createElement("div");
  setAttributes(div, {"class": "form-group text required question_question" });
  var label = document.createElement("label");
  setAttributes(label, {"class": "control-label text required", "for": "question_question"})
  label.appendChild(document.createTextNode("Question:"))
  var input0 = document.createElement("input");
  setAttributes(input0, {"class":"form-control string optional q", "type":"text", "name": "question[question]", "id": "question_question", "onblur":"toggleBlurNewQ(this.className)"});
  var submit = document.createElement("input");
  setAttributes(submit, {"type": "submit", "id": "btn-q", "data-disable-with": "Create Question", "class": "hidden"});

  var del = document.createElement("a");
  setAttributes(del, {"id": "btn-dq", "class": "fa fa-remove delete-q", "onClick": "deleteQuestionJS()"})



  div.appendChild(label);
  div.appendChild(input0);
  form.appendChild(input1);
  // form.appendChild(input2);
  // form.appendChild(input3);
  form.appendChild(div);
  form.appendChild(submit);
  newQ.appendChild(del);
  newQ.appendChild(form);
  jsArea.appendChild(newQ);

});

// <a type="button" id="<%= "btn-da-#{answer.id}" %>" class="fa fa-remove delete-q" onClick="deleteAnswer(this.id)"></a>
//   <a id="d-btn-da-414" class="hidden" data-remote="true" rel="nofollow" data-method="delete" href="/answers/414"></a>

var addAnswer = ((question_id)=>{
  var del = document.createElement("a");
  setAttributes(del, {"id": "btn-da", "class": "fa fa-remove delete-q", "onClick": "deleteAnswerJS()"})
  var form = document.createElement("form");
  setAttributes(form, {"novalidate": "novalidate","id":"new_answer", "class": "simple_form_new_answer form-a", "action": `/questions/${question_id}/answers`, "accept-charset":"UTF-8", "data-remote": "true", "method": "post"})
  var input1 = document.createElement("input");
  setAttributes(input1, {"name":"utf8", "type": "hidden", "value": "✓"});
  var div =  document.createElement("div");
  setAttributes(div, {"class": "form-group text required answer_answer" });
  var label = document.createElement("label");
  setAttributes(label, {"class": "control-label text required", "for": "answer_answer"})
  label.appendChild(document.createTextNode("Réponse:"))
  var input0 = document.createElement("input");
  setAttributes(input0, {"class":"form-control string optional a", "type":"text", "name": "answer[answer]", "id": "answer_answer", "onblur":"toggleBlur(this.className)"});
  var submit = document.createElement("input");
  setAttributes(submit, {"type": "submit", "name": "commit", "value": "Create Answer", "id": "btn-a", "data-disable-with": "Create Answer", "class": "hidden"});
  var tabAns = document.createElement("div");
  setAttributes(tabAns,{"class": "tab-answer answer"});


  div.appendChild(label);
  div.appendChild(input0);
  form.appendChild(input1);
  // form.appendChild(input2);
  // form.appendChild(input3);
  form.appendChild(div);
  form.appendChild(submit);
  tabAns.appendChild(del);
  tabAns.appendChild(form);


  var addAnsBtn = document.querySelector(`.tab-add-answer${question_id}`);
  console.log(addAnsBtn);
  addAnsBtn.parentNode.insertBefore(tabAns, addAnsBtn);


});


function setAttributes(el, attrs) {
  for(var key in attrs) {
    el.setAttribute(key, attrs[key]);
  }
};


var deleteAnswerJS = (()=> {
  var answer = document.querySelector(".answer");
  answer.remove();
});

var deleteQuestionJS = (()=> {
  var question = document.getElementById("question");
  question.remove();
});

window.deleteQuestionnaire = deleteQuestionnaire;
window.deleteQuestion = deleteQuestion;
window.deleteAnswer = deleteAnswer;
window.deleteAnswerJS = deleteAnswerJS;
window.deleteQuestionJS = deleteQuestionJS;

window.addNextQuestion = addNextQuestion;
window.toggleQ = toggleQ
window.toggleBlur = toggleBlur
window.addQuestionForm = addQuestionForm
window.toggleBlurNewQ = toggleBlurNewQ
window.addAnswer = addAnswer
