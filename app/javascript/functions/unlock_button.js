import { initSweetalert } from "../plugins/init_sweetalert";

export const unlockButtonAlert = (unlockButton) => {
    // Check if tag is locked or unlocked
    const isLocked = unlockButton.innerText == "Desbloquear";

    if (isLocked){
      initSweetalert(
        "#sweet-alert-unlock-tag",
        {
          title: "<div class='mt-3'><p>Debloquear TAG</p></div>",
          html: "<div><p>Insira o código da sua TAG...</p><img class='mt-3' src='/assets/images/carrefour-tag.png' height='auto', width='90%'></div>",
          input: "text",
          inputAttributes: {
            autocapitalize: "on",
          },
          showCancelButton: true,
          inputPlaceholder: "Digite seu código",
          inputValidator: (value) => {
            if (!value) {
              return "Digite o código da sua TAG";
            }
          },
          icon: "",
          confirmButtonText: 'Desbloquear <i class="fas fa-lock-open"></i>',
        },
        (value) => {
          console.log(value);
          if (value.isConfirmed) {
            const link = unlockButton.nextElementSibling;
            link.click();
          }
        }
      );
    } else {
      initSweetalert(
        "#sweet-alert-unlock-tag",
        {
          title: "Bloquear TAG",
          html: "Selecione o motivo do bloqueio",
          input: "select",
          showCancelButton: true,
          inputOptions: {
            robbery: 'O veículo foi roubado',
            tow: 'O veículo precisa ser guinchado',
            other: 'Outro'
          },
          inputPlaceholder: 'Selecione uma opção',
          inputValidator: (value) => {
            if (!value) {
              return "Digite o motivo do bloqueio";
            }
          },
          icon: "question",
          confirmButtonText: 'Bloquear <i class="fas fa-lock"></i>',
        },
        (value) => {
          console.log(value);
          if (value.isConfirmed) {
            const link = unlockButton.nextElementSibling;
            link.click();
          }
        }
      );
    }
};
