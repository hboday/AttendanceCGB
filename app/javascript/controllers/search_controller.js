import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "employee", "hiddenCount"]

  filter() {
    const query = this.inputTarget.value.toLowerCase()
    let hiddenSelectedCount = 0

    this.employeeTargets.forEach((employee) => {
      const checkbox = employee.querySelector('input[type="checkbox"]')
      const name = employee.textContent.trim().toLowerCase()
      const shouldBeHidden = !name.includes(query)

      employee.classList.toggle("d-none", shouldBeHidden)

      if (shouldBeHidden && checkbox.checked) {
        hiddenSelectedCount++
      }
    })

    if (hiddenSelectedCount > 0) {
      this.hiddenCountTarget.textContent = `+ ${hiddenSelectedCount} selected`
      this.hiddenCountTarget.classList.remove("d-none")
    } else {
      this.hiddenCountTarget.classList.add("d-none")
    }
  }
}