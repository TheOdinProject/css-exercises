const openButton = document.getElementById('trigger-modal');
const closeButton = document.getElementById('close-modal');

function openModal() {
  const container = document.querySelector('.popup-container');
  const modalDiv = document.querySelector('.popup-modal');
  modalDiv.classList.add('show');
  container.classList.add('show');
}

function closeModal() {
  const container = document.querySelector('.popup-container.show');
  const modalDiv = document.querySelector('.popup-modal.show');
  modalDiv.classList.remove('show');
  container.classList.remove('show');
}

openButton.addEventListener('click', openModal);
closeButton.addEventListener('click', closeModal);
