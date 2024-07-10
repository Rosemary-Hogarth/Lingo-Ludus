import { Controller } from "@hotwired/stimulus"
import confetti from 'canvas-confetti'

export default class extends Controller {

initialize() {
    console.log('hello from confetti controller')
  }

  shoot() {
    const defaults = {
      spread: 120,  // angle: higher number = larger spread
      ticks: 120, // lifespan: higher number = longet life
      gravity: 0.7, // fall rate: higher = faster fall
      decay: 0.9, // decrease rate: lower value = slower
      startVelocity: 50,
      colors: ['#F5BC3A', '#ff6041', '#17BBB0', '#9163EA', '#1097E1']
    };

    confetti({
      ...defaults,
      particleCount: 200,
      spread: 100,
      shapes: ['star']
    });
  }

  showConfetti() {
    setTimeout(this.shoot, 0);
    setTimeout(this.shoot, 100);
    setTimeout(this.shoot, 200);
    setTimeout(this.shoot, 300);
  }
}
