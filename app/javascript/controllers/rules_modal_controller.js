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
    if (this.isOnGamePage()) {
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
          console.log("Before resetting modal:", this.modal);
          this.modal = null; // Reset modal instance
          console.log("After resetting modal:", this.modal);
        });
      }

      // Show the modal if it's not already shown
      if (!modalElement.classList.contains('show')) {
        console.log("Showing the modal");
        this.modal.show();
      }
    }
  }

  isOnGamePage() {
    return window.location.pathname === '/play';
  }
}
