import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];
  modal = null;

  connect() {
    console.log('Hello from rules_modal_controller');
    this.showModalOnGamePage();
  }

  showModalOnGamePage() {
    console.log("showModalOnGamePage called");
    if (this.isOnGamePage() && !this.hasModalBeenShown()) {
      // Retrieve the modal element
      const modalElement = this.modalTarget;

      // Initialize Bootstrap modal if it hasn't been initialized yet
      if (!this.modal) {
        this.modal = new bootstrap.Modal(modalElement);

        // Handle modal hidden event to clean up modal instance
        modalElement.addEventListener('hidden.bs.modal', () => {
          console.log("hidden.bs.modal event triggered");
          this.modal.dispose();
          console.log("Modal disposed");
          this.modal = null; // Reset modal instance
        });
      }

      // Show the modal
      console.log("Showing the modal");
      this.modal.show();

      // Mark the modal as shown
      this.markModalAsShown();
    }
  }

  isOnGamePage() {
    return window.location.pathname === '/play';
  }

  hasModalBeenShown() {
    return sessionStorage.getItem('rulesModalShown') === 'true';
  }

  markModalAsShown() {
    sessionStorage.setItem('rulesModalShown', 'true');
  }
}
