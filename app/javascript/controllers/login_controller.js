import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["email", "password", "error"]

  togglePassword(event) {
    this.passwordTarget.type = event.target.checked ? "text" : "password"
  }

  validate(event) {
    this.errorTarget.textContent = ""

    if (
      this.emailTarget.value.trim() === "" ||
      this.passwordTarget.value.trim() === ""
    ) {
      event.preventDefault()
      this.errorTarget.textContent = "Please enter both email and password."
    }
  }
}