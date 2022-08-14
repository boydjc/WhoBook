import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // method for alerting before deleting posts
  delete(event) {
    let confirmed = confirm("Are you sure?");

    if(!confirmed) {
      event.preventDefault();
    }
  }
}