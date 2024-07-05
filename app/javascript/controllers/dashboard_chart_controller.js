import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {

  connect() {
    const dashboardChartData = JSON.parse(this.element.dataset.dashboardChartDataValue);
    console.log(dashboardChartData);


    const difficultyLevels = Object.keys(dashboardChartData);
    const attemptsData = Object.values(dashboardChartData);

       // Define colors for each difficulty level
      const backgroundColors = [
        'rgba(201, 203, 207, 0.2)',  // Beginner
        'rgba(201, 203, 207, 0.2)',  // Intermediate
        'rgba(201, 203, 207, 0.2)',  // Advanced
      ];

      const borderColors = [
        'rgba(75, 192, 192)',    // Beginner
        'rgba(75, 192, 192)',    // Intermediate
        'rgba(75, 192, 192)',    // Advanced
      ];

    // Create the chart
    new Chart(this.element, {
      type: 'bar',
      data: {
        labels: difficultyLevels,
        datasets: [{
          label: 'Attempts',
          data: attemptsData,
          borderWidth: 1,
          borderColor: borderColors.slice(0, difficultyLevels.length),
          backgroundColor: backgroundColors.slice(0, difficultyLevels.length)
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
