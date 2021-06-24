
const arrow_up = () => {
  const buttons = document.querySelectorAll('.accordion-btn');
  buttons.forEach((button) => {
    button.addEventListener('click', () => {
      if (button.getAttribute('aria-expanded') === 'false') {
        button.querySelector('.fas').classList.remove('fa-sort-down');
        button.querySelector('.fas').classList.add('fa-sort-up');
      } else if (button.getAttribute('aria-expanded') === 'true'){
        button.querySelector('.fas').classList.remove('fa-sort-up');
        button.querySelector('.fas').classList.add('fa-sort-down');
      }
    }) 
  })
}

export { arrow_up };
