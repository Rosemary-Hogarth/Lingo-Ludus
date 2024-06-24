import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ["shapes"];


  connect() {
      // Check if the current page is the homepage
      if (window.location.pathname === "/") {
        this.hideNavbar();
      }
      this.animateSquares();
  }


  hideNavbar() {
    const navbar = document.querySelector(".navbar");
    if (navbar) {
      navbar.style.display = "none";
    }
  }


  animateSquares() {
    this.shapesTargets.forEach((shape, index) => {
      // Set initial state outside the viewport
      shape.style.transform = index % 2 === 0 ? 'translateX(-100vw)' : 'translateX(100vw)';
      shape.style.transition = 'transform 5s cubic-bezier(0.25, 1, 0.5, 1)';


    // Trigger animation
      setTimeout(() => {
        shape.style.transform = 'translateX(0)';
      }, index * 200); // stagger the animation
    });
  }
}



//  // function to create and add squares
//  generateSquares = () => {
//   const shapes = this.shapesTarget;

//   for (let i = 0; i < 10; i++) {
//     const square = document.createElement('div');
//     square.classList.add('square');
//     shapes.appendChild(square);
//   }
// };
