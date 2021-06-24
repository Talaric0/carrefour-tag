import Swal from "sweetalert2";

const initSweetalert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) {
    swalButton.addEventListener("click", () => {
      Swal.fire(options).then(callback);
    });
  }
};

export { initSweetalert };
