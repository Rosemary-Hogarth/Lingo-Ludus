import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {
  connect() {
    this.initializeChart();
    document.body.addEventListener('darkModeChanged', this.handleDarkModeChange.bind(this));
  }

  disconnect() {
    document.body.removeEventListener('darkModeChanged', this.handleDarkModeChange.bind(this));
  }

  initializeChart() {
    const dashboardChartData = JSON.parse(this.element.dataset.dashboardChartDataValue);
    console.log(dashboardChartData);

    const difficultyLevels = Object.keys(dashboardChartData);
    const attemptsData = Object.values(dashboardChartData);

    const isDarkMode = document.body.classList.contains('dark-mode');

    const colors = this.getChartColors(isDarkMode);

    this.chart = new Chart(this.element, {
      type: 'bar',
      data: {
        labels: difficultyLevels,
        datasets: [{
          label: 'Attempts',
          data: attemptsData,
          borderWidth: 1,
          borderColor: colors.borderColors.slice(0, difficultyLevels.length),
          backgroundColor: colors.backgroundColors.slice(0, difficultyLevels.length)
        }]
      },
      options: this.getChartOptions(isDarkMode)
    });
  }

  getChartColors(isDarkMode) {
    if (isDarkMode) {
      return {
        backgroundColors: [
          'rgba(201, 203, 207, 0.2)'  // Darker for dark mode
        ],
        borderColors: [
          // 'rgb(153, 102, 255)',
          'rgb(0, 0, 0)'// Brighter for dark mode
        ]
      };
    } else {
      return {
        backgroundColors: [
          'rgba(201, 203, 207, 0.2)'

        ],
        borderColors: [
          'rgba(75, 192, 192)'
        ]
      };
    }
  }

  getChartOptions(isDarkMode) {
    return {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true,
          stepSize: 1,
          title: {
            display: true,
            text: 'Number of Attempts',
            color: isDarkMode ? '#ffffff' : '#666666'
          },
          ticks: {
            color: isDarkMode ? '#ffffff' : '#666666'
          },
          grid: {
            color: isDarkMode ? 'rgba(0, 0, 0, 0.1)' : 'rgba(1, 1, 1, 0.1)'
          }
        },
        x: {
          title: {
            display: true,
            text: 'Difficulty Levels',
            color: isDarkMode ? '#ffffff' : '#666666'
          },
          ticks: {
            color: isDarkMode ? '#ffffff' : '#666666'
          },
          grid: {
            color: isDarkMode ? 'rgba(0, 0, 0, 0.1)' : 'rgba(0, 0, 0, 0.1)'
          }
        }
      },
      plugins: {
        legend: {
          labels: {
            color: isDarkMode ? '#ffffff' : '#666666'
          }
        }
      }
    };
  }

  handleDarkModeChange(event) {
    const isDarkMode = event.detail.isDarkMode;
    const colors = this.getChartColors(isDarkMode);

    this.chart.data.datasets[0].borderColor = colors.borderColors;
    this.chart.data.datasets[0].backgroundColor = colors.backgroundColors;

    this.chart.options = this.getChartOptions(isDarkMode);

    this.chart.update();
  }
}
