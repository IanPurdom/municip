import Sortable from 'sortablejs/Sortable.js';

var categories = document.getElementById("category-array").dataset.categories
categories = categories.replace(/[^a-zA-Z | , | éèàêçù ]/g , "");
categories = categories.replace(/ /g,'');
var categoryArray = categories.split(",")

// console.log(categories);
// console.log(categoryArray);
// console.log(`listWithHandle-${categoryArray[0]}`);

var listWithHandle = [];
for(var i = 0; i < categoryArray.length; ++i){
  listWithHandle[i] = document.getElementById(`listWithHandle-${categoryArray[i]}`);
  Sortable.create(listWithHandle[i], {
    handle: '.glyphicon-move',
    animation: 150
  });
};

// var sendIdList = (()=> {
//     console.log("coucou!");
//     console.log(cross[i][j]);
//     // var category = categoryArray[index];
//     // var list = document.getElementsByClassName(`q-id-${category}`);
//     // var form = document.getElementById(`form-${category}`)
//     // for (var i = 0; i < list.length; ++i) {
//     //   form.value = form.value + " " + list[i].innerText;
//     // };
//     // console.log(form.value);
//     // // document.getElementById(`btn-${category}`).click();
//     // // form.value = "";
// })

// var cross = [];
// for(var i = 0; i < categoryArray.length; ++i) {
//   cross[i] = document.getElementsByClassName(`${categoryArray[i]}`);
//   for (var j = 0; j < cross[i].length; ++j) {
//     cross[i][j].addEventListener('drop', (sendIdList(cross[i][j])));
//   };
// };


var orderQuest = ((clicked_class) => {
  var class_array = clicked_class.split(" ");
  var category = class_array.slice(-1)[0];
  var list = document.getElementsByClassName(`q-id-${category}`);
  var form = document.getElementById(`form-${category}`)
  for (var i = 0; i < list.length; ++i) {
    form.value = form.value + " " + list[i].innerText;
  };
  console.log(form.value);
  document.getElementById(`btn-${category}`).click();
  form.value = "";
});

// always put this at the end of the sheet otherwise function is not recognized!!
window.orderQuest = orderQuest;
