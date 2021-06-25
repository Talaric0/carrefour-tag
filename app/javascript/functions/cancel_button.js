import { initSweetalert } from "../plugins/init_sweetalert";

export const cancelButtonAlert = (cancelButtons) => {
  cancelButtons.forEach((button) => {
    initSweetalert(
      "#sweet-alert-cancel-tag",
      {
        title: "Cancelar TAG",
        text: "Tem certeza que deseja cancelar essa TAG?",
        showCancelButton: true,
        icon: "error",
        confirmButtonText: "Excluir TAG",
      },
      (value) => {
        console.log(value);
        if (value.isConfirmed) {
          const link = button.nextElementSibling;
          link.click();
        }
      }
    );
  });
};
