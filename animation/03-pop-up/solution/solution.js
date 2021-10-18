const openButton = document.getElementById('open-modal');
const closeButton = document.getElementById('close-modal');

function openModal() {
  const modalDiv = document.querySelector('.popup-modal');
  modalDiv.classList.add('show');
}

function closeModal() {
  const modalDiv = document.querySelector('.popup-modal.show');
  modalDiv.classList.remove('show');
}

openButton.addEventListener('click', openModal);
closeButton.addEventListener('click', closeModal);
