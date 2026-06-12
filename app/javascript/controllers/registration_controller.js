import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "firstName",
    "lastName",
    "email",
    "password",
    "passwordConfirmation",
    "error"
  ]

  validate(event) {
    this.errorTarget.textContent = ""

    if (
      this.firstNameTarget.value.trim() === "" ||
      this.lastNameTarget.value.trim() === "" ||
      this.emailTarget.value.trim() === "" ||
      this.passwordTarget.value.trim() === "" ||
      this.passwordConfirmationTarget.value.trim() === ""
    ) {
      event.preventDefault()
      this.errorTarget.textContent = "Please complete all fields."
      return
    }

    if (this.passwordTarget.value !== this.passwordConfirmationTarget.value) {
      event.preventDefault()
      this.errorTarget.textContent = "Passwords do not match."
    }
  }
}