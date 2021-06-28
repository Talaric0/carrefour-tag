import { initSweetalert } from "../plugins/init_sweetalert";

export const unlockButtonAlert = (unlockButton) => {
    // Check if tag is locked or unlocked
    const isLocked = unlockButton.innerText == "Desbloquear";

    initSweetalert(
      "#sweet-alert-unlock-tag",
      {
        title: isLocked ? "Debloquear TAG" : "Bloquear TAG",
        text: isLocked
          ? "Insira o código enviado por email..."
          : "Insira o motivo do bloqueio",
        input: "text",
        inputAttributes: {
          autocapitalize: "on",
        },
        showCancelButton: true,
        inputPlaceholder: isLocked
          ? "Digite seu código"
          : "Motivo do bloqueio...",
        inputValidator: (value) => {
          if (!value) {
            return isLocked
              ? "Digite o código enviado para seu email"
              : "Digite o motivo do bloqueio";
          }
        },
        icon: "question",
        confirmButtonText: isLocked
          ? 'Desbloquear <i class="fas fa-lock-open"></i>'
          : 'Bloquear <i class="fas fa-lock"></i>',
      },
      (value) => {
        console.log(value);
        if (value.isConfirmed) {
          const link = unlockButton.nextElementSibling;
          link.click();
        }
      }
    );
};
