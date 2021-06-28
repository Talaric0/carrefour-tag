import { initSweetalert } from "../plugins/init_sweetalert";

export const unlockButtonAlert = (unlockButton) => {
    // Check if tag is locked or unlocked
    const isLocked = unlockButton.innerText == "Desbloquear";

    initSweetalert(
      "#sweet-alert-unlock-tag",
      {
        title: isLocked ? "<div class='mt-3'><p>Debloquear TAG</p></div>" : "Bloquear TAG",
        html: isLocked
          ? "<div><p>Insira o código da sua TAG...</p><img class='mt-3' src='/assets/images/carrefour-tag.png' height='auto', width='90%'></div>"
          : "Insira o motivo do bloqueio",
        input: isLocked ? "text" : "select",
        inputOptions: {
          'Fruits': {
            apples: 'Apples',
            bananas: 'Bananas',
            grapes: 'Grapes',
            oranges: 'Oranges'
          },
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
              ? "Digite o código da sua TAG"
              : "Digite o motivo do bloqueio";
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
