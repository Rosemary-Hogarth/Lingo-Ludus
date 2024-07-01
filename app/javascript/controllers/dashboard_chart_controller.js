import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {

  connect() {
    const dashboardChartData = JSON.parse(this.element.dataset.dashboardChartDataValue);
    console.log(dashboardChartData);


    const difficultyLevels = Object.keys(dashboardChartData);
    const attemptsData = Object.values(dashboardChartData);
    // Create the chart
    new Chart(this.element, {
      type: 'bar',
      data: {
        labels: difficultyLevels,   // Use the days as labels --> see dashboard#index
        datasets: [{
          label: 'Attempts',
          data: attemptsData, // Use the scores as data  --> see dashboard#index
          borderWidth: 1,
          borderColor: 'pink',
          backgroundColor: 'rgba(0, 0, 255, 0.2)'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            stepSize: 1,
            title: {
              display: true,
              text: 'Number of Attempts'
            }
          },
          x: {
            title: {
              display: true,
              text: 'Difficulty Levels'
            }
          }
        }
      }
    });
  }
}
