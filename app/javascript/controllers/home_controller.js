import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ["container", "shapes"];

  id = null;
  pos = 0;

  connect() {
      // Check if the current page is the homepage
      if (window.location.pathname === "/") {
        this.hideNavbar();
      }
      this.myMove();
  }


  hideNavbar() {
    const navbar = document.querySelector(".navbar");
    if (navbar) {
      navbar.style.display = "none";
    }
  }


  myMove = () => {
    const shapes = this.shapesTarget;
    if (!shapes) return;

    clearInterval(id);
    this.id = setInterval(this.frame.bind(this), 10);
  }

  frame() {
    const shapes = this.shapesTarget;
      if (this.pos == 350) {
        clearInterval(this.id);
      } else {
        this.pos++;
        shapes.style.top = this.pos + 'px';
        shapes.style.left = this.pos + 'px';
      }
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
