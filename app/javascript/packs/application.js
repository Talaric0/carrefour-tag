// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
import { accordion_arrow } from "../components/accordion_arrow";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import $ from "jquery";
import "select2";
import swal from "sweetalert2";

// Internal imports, e.g:
import { updateTagModel } from "../plugins/update_forms";
import { previewImageOnFileSelect } from "../functions/photo_preview";
import { initSweetalert } from "../plugins/init_sweetalert";
import { initAutocomplete } from "../plugins/init_autocomplete";
import { unlockButtonAlert } from "../functions/unlock_button";
import { cancelButtonAlert } from "../functions/cancel_button";

document.addEventListener("turbolinks:load", () => {
  // Algolia autocomplete
  initAutocomplete();

  // Sweet alert stuff
  // lock/unlock btns
  const unlockButtons = document.querySelectorAll(
    ".btns-wrapper > button:nth-of-type(2)"
  );
  if (unlockButtons) {
    unlockButtonAlert(unlockButtons);
  }

  // cancel tag buttons
  const cancelButtons = document.querySelectorAll(
    ".btns-wrapper > button:nth-child(1)"
  );
  if (cancelButtons) {
    cancelButtonAlert(cancelButtons);
  }

  previewImageOnFileSelect();

  // form stuff
  const tagMaker = document.getElementById("tag_maker");
  const tagModel = document.getElementById("tag_model");

  if (tagMaker && tagModel) {
    document.querySelectorAll("#tag_maker > option").forEach((option) => {
      option.innerText = option.value.split("-")[1] || "";
    });

    tagMaker.addEventListener("change", () => {
      updateTagModel(tagMaker.value.split("-")[0], tagModel);
    });
  }

  if (document.querySelectorAll(".accordion-btn")) {
    accordion_arrow();
  }
});
