import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {

  static targets = ["slidebar", "toggleButton"];
  static classes = ["open"];
  static values = { sidebarUserId: Number };

  connect() {
    this.slidebarTarget.addEventListener('click', () => {
      this.toggle();
    });
  }

  disconnect() {
    this.slidebarTarget.removeEventListener('click', () => {
      this.toggle();
    });
  }

  toggle() {
    this.slidebarTarget.classList.toggle(this.openClass);
    const isOpen = this.slidebarTarget.classList.contains(this.openClass);
    const text = isOpen ? "Close Notifications" : "Open notifications";
    this.toggleButtonTarget.textContent = text;

    if (!isOpen) {
      const userId = this.data.get("userId")
      window.location.href = `/employees/${userId}`;
    }
  }
}
