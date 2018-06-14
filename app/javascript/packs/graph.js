google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);



function drawChart() {

  var grapElement = document.getElementById("curve_chart");
  var amap = JSON.parse(grapElement.dataset.amap)

  // console.log(amap)

  var data = google.visualization.arrayToDataTable(
      amap
      );
  var options = {
    title: "en milliers d'euros",
    subtitle: "en milliers d'euros",
    legend: { position: 'bottom' },
    hAxis: {title: 'Time',format: 'yyyy'}
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
  chart.draw(data, options);
}



window.drawChart = drawChart;

