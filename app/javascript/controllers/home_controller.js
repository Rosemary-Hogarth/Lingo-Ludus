import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ["shapes", "container"];


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
      console.log(`Shape: ${shape}, Index: ${index}`);

    // Trigger animation
      setTimeout(() => {
        shape.style.transform = 'translateX(0)';
      }, index * 200); // stagger the animation
    });

      // Redirect to games page after the animation finishes
      const homepageDuration = this.shapesTargets.length * 200 + 5300;
      console.log(homepageDuration) // (last index delay + animation duration)
      setTimeout(() => {
        this.fadeOutAndRedirect();
      }, homepageDuration);
    }

    fadeOutAndRedirect() {
      const container = this.containerTarget;
      console.log(this.containerTarget)

      container.classList.add('fade-out');
      setTimeout(() => {
        window.location.href = "/play";
      }, 1000);
    }
  }
