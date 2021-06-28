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
          : "Selecione o motivo do bloqueio",
        input: isLocked ? "" : "select",
        showCancelButton: true,
        inputOptions: {
            robbery: 'O veículo foi roubado',
            tow: 'O veículo precisa ser guinchado',
            other: 'Outro'
        },
        inputPlaceholder: isLocked
          ? "Digite seu código"
          : "Selecione uma opção",
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
