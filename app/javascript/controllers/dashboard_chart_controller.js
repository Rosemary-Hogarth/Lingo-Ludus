import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {

  connect() {
    const dashboardChartData = JSON.parse(this.element.dataset.dashboardChartDataValue);
    console.log(dashboardChartData);
    // Create the chart
    new Chart(this.element, {
      type: 'line',
      data: {
        labels: Object.keys(dashboardChartData),   // Use the days as labels --> see dashboard#index
        datasets: [{
          label: 'Average Scores',
          data: Object.values(dashboardChartData), // Use the scores as data  --> see dashboard#index
          borderWidth: 1,
          borderColor: 'pink',
          backgroundColor: 'rgba(0, 0, 255, 0.2)'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false
      }
    });
  }
}



// Get the canvas element
// const canvas = document.querySelector('[data-controller="dashboard-chart"]');

// Parse the JSON data from the attribute
