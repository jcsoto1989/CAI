var chartData; // globar variable for hold chart data  
google.load("visualization", "1", { packages: ["corechart"] });
// Here We will fill chartData  
$(document).ready(function () {
    $.ajax({
        url: "index.aspx/GetChartData",
        data: "",
        dataType: "json",
        type: "POST",
        contentType: "application/json; chartset=utf-8",
        success: function (data) {
            chartData = data.d;
        },
        error: function () {
            alert("Error loading data! Please try again.");
        }
    }).done(function () {
        // after complete loading data  
        google.setOnLoadCallback(drawChart);
        drawChart();
    });
});
function drawChart() {
    var data = google.visualization.arrayToDataTable(chartData);
    var options = {
        title: "Company Hiring Report",
        pointSize: 5
    };
    var lineChart = new google.visualization.LineChart(document.getElementById('chart_div'));
    lineChart.draw(data, options);
}