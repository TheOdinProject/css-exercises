const openButton = document.getElementById('trigger-modal');
const closeButton = document.getElementById('close-modal');

function toggleModal() {
  const container = document.querySelector('.button-container');
  const modalDiv = document.querySelector('.popup-modal');
  modalDiv.classList.toggle('show');
  container.classList.toggle('show');
}

openButton.addEventListener('click', toggleModal);
closeButton.addEventListener('click', toggleModal);
