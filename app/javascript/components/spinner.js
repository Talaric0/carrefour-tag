
const spinner = () => {
  const spinnerFormButton = document.querySelector('.spinner-form-button');
  spinnerFormButton.addEventListener('click', () =>{
    document.getElementById('spinner').style.display = 'none';
  })
  document.querySelector('.spinner-button').addEventListener('click', () => {
    document.getElementById('spinner').style.display = 'block';
    document.querySelector('.modal-footer').style.display = 'none';
  })
}

export { spinner };
