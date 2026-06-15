import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.savePositions()
  }

  savePositions() {
    this.positions = {}

    this.element.querySelectorAll("[data-nav-item-id]").forEach((item) => {
      this.positions[item.dataset.navItemId] = item.getBoundingClientRect()
    })
  }

  animate() {
    this.element.querySelectorAll("[data-nav-item-id]").forEach((item) => {
      const oldPosition = this.positions[item.dataset.navItemId]
      if (!oldPosition) return

      const newPosition = item.getBoundingClientRect()

      const deltaY = oldPosition.top - newPosition.top

      if (deltaY === 0) return

      item.animate(
        [
          { transform: `translateY(${deltaY}px)` },
          { transform: "translateY(0)" }
        ],
        {
          duration: 220,
          easing: "ease-out"
        }
      )
    })

    this.savePositions()
  }
}