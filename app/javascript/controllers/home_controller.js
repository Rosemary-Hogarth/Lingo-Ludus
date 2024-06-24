import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ["container", "shapes"];
  connect() {
      // Check if the current page is the homepage
      if (window.location.pathname === "/") {
        this.hideNavbar();
      }
      this.generateSquares();
  }


  hideNavbar() {
    const navbar = document.querySelector(".navbar");
    if (navbar) {
      navbar.style.display = "none";
    }
  }


  // function to create and add squares
    generateSquares = () => {
      const shapes = this.shapesTarget;

      for (let i = 0; i < 10; i++) {
        const square = document.createElement('div');
        square.classList.add('square');
        shapes.appendChild(square);
      }
    };
  }
