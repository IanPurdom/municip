google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);



function drawChart(amap) {

  var grapElement = document.getElementById("curve_chart");
  var amap = JSON.parse(grapElement.dataset.amap)

    console.log(amap)

  var data = google.visualization.arrayToDataTable([
    ['Year', 'Autofinancement', 'Charges personnel', 'Dette', 'Charges financières', 'Produit total'],
    amap[0],
    amap[1],
    amap[2],
    amap[3],
    amap[4],
    amap[5],
    amap[6],
    amap[7],
    amap[8],
    amap[9],
    amap[10],
    amap[11],
    amap[12],
    amap[13],
    amap[14],
    amap[15],
    amap[16]
      ]);
  var options = {
    title: "en milliers d'euros",
    subtitle: "en milliers d'euros",
    legend: { position: 'bottom' },
    hAxis: {title: 'Time',format: 'yyyy'
}
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

  chart.draw(data, options);
}



window.drawChart = drawChart;


// var data = google.visualization.arrayToDataTable([
//   ['Année', 'Autofinancement', 'Charges personnel', 'Dette', 'Charges financières', 'Produit total'],
//   ['2004',  1000,      400],
//   ['2005',  1170,      460],
//   ['2006',  660,       1120],
//   ['2007',  1030,      540]
// ]);
