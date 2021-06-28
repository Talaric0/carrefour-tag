import { initSweetalert } from "../plugins/init_sweetalert";

export const temporaryLockAlert = (unlockButton) => {
    // Check if tag is locked or unlocked
    const isLocked = unlockButton.innerText == "Desbloquear";

    initSweetalert(
      "#sweet-alert-temporary-lock-tag",
      {
        title: isLocked ? "<div class='mt-3'><p>Debloquear TAG</p></div>" : "Bloquear TAG",
        html: isLocked
          ? "Deseja desfazer o bloqueio temporário?"
          : "Insira o motivo do bloqueio",
        input: isLocked ? "" : "text",
        inputAttributes: {
          autocapitalize: "off",
        },
        showCancelButton: true,
        inputPlaceholder: isLocked
          ? "Digite seu código"
          : "Motivo do bloqueio...",
        inputValidator: (value) => {
          if (!value) {
            return "Digite o motivo do bloqueio";
          }
        },
        icon: isLocked ? "" : "question",
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
