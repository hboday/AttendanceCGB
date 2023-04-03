import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {

  static targets = ["slidebar", "toggleButton"];
  static classes = ["open"];



  toggle() {
    this.slidebarTarget.classList.toggle(this.openClass);
    const text = this.slidebarTarget.classList.contains(this.openClass) ? "Close Notifications" : "Open notifications";
    this.toggleButtonTarget.textContent = text;
  }
}

