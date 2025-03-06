// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".custom-card").forEach(card => {
      card.addEventListener("click", function (event) {
        // If the user clicks the modal trigger button, prevent navigation
        if (event.target.closest(".btn, .modal")) return;

        // Redirect to the horse's show page
        window.location.href = this.getAttribute("data-horse-url");
      });
    });
  });
