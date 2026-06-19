import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  moveUp(event) {
    const item = event.target.closest("[data-nav-reorder-item]")
    const previous = item.previousElementSibling

    if (!previous || !previous.matches("[data-nav-reorder-item]")) return

    item.parentNode.insertBefore(item, previous)
    this.updatePositions(item.parentNode)
  }

  moveDown(event) {
    const item = event.target.closest("[data-nav-reorder-item]")
    const next = item.nextElementSibling

    if (!next || !next.matches("[data-nav-reorder-item]")) return

    item.parentNode.insertBefore(next, item)
    this.updatePositions(item.parentNode)
  }

  addTopLevel() {
    const tree = this.element.querySelector(".nav-tree")
    const newId = `new_${Date.now()}`

    const wrapper = document.createElement("div")
    wrapper.classList.add("nav-parent-card")
    wrapper.dataset.navReorderItem = ""

    wrapper.innerHTML = this.parentRowHtml(newId)

    tree.appendChild(wrapper)
    this.updatePositions(tree)
  }

  addChild() {
    const parents = this.element.querySelectorAll(".nav-parent-card")
    const parent = parents[parents.length - 1]
    if (!parent) return

    const parentId = this.extractNavItemId(parent)
    const newId = `new_${Date.now()}`

    let childrenContainer = parent.querySelector(".nav-children-container")

    if (!childrenContainer) {
      childrenContainer = document.createElement("div")
      childrenContainer.classList.add("nav-children-container")
      parent.appendChild(childrenContainer)
    }

    const child = document.createElement("div")
    child.classList.add("nav-child-row")
    child.dataset.navReorderItem = ""
    child.innerHTML = this.childRowHtml(newId, parentId)

    childrenContainer.appendChild(child)
    this.updatePositions(childrenContainer)
  }

  updatePositions(container) {
    const items = container.querySelectorAll(":scope > [data-nav-reorder-item]")

    items.forEach((item, index) => {
      const positionField = item.querySelector(".position-field")
      if (positionField) positionField.value = index + 1
    })
  }

  extractNavItemId(parent) {
    const input = parent.querySelector("input[name^='nav_items']")
    if (!input) return ""

    const match = input.name.match(/nav_items\[(.*?)\]/)
    return match ? match[1] : ""
  }

  parentRowHtml(id) {
    return `
      <div class="nav-parent-row">
        ${this.fieldsHtml(id, "")}
        ${this.buttonsHtml()}
      </div>
    `
  }

  childRowHtml(id, parentId) {
    return `
      ${this.fieldsHtml(id, parentId)}
      ${this.buttonsHtml()}
    `
  }

  fieldsHtml(id, parentId) {
    return `
      <div class="nav-info nav-inline-title">
        <input type="hidden"
               name="nav_items[${id}][position]"
               value="1"
               class="position-field">

        <input type="hidden"
               name="nav_items[${id}][parent_id]"
               value="${parentId}">

        <input type="text"
               name="nav_items[${id}][title]"
               value=""
               placeholder="New menu item"
               class="nav-title-input">

        <label class="nav-inline-visible">
          <input type="hidden"
                 name="nav_items[${id}][visible]"
                 value="0">

          <input type="checkbox"
                 name="nav_items[${id}][visible]"
                 value="1"
                 checked>

          Visible
        </label>
      </div>
    `
  }

  buttonsHtml() {
    return `
      <div class="nav-actions">
        <button type="button"
                class="reorder-button"
                data-action="click->nav-reorder#moveUp">↑</button>

        <button type="button"
                class="reorder-button"
                data-action="click->nav-reorder#moveDown">↓</button>

        <button type="button"
                class="reorder-button nav-delete-btn"
                data-action="click->nav-reorder#deleteItem">×</button>
      </div>
    `
  }
  deleteItem(event) {
    const item = event.target.closest("[data-nav-reorder-item]")
    if (!item) return

    const destroyField = item.querySelector(".destroy-field")
    const container = item.parentNode

    if (destroyField) {
      destroyField.value = "1"
      item.style.display = "none"
    } else {
      item.remove()
    }

    if (container) this.updatePositions(container)
  }
}