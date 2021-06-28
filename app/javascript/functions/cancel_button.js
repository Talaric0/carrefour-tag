import { initSweetalert } from "../plugins/init_sweetalert";

export const cancelButtonAlert = (cancelButton) => {
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
          const link = cancelButton.nextElementSibling;
          link.click();
        }
      }
    );
};
