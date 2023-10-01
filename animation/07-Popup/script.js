const poped = document.querySelector('#poped');
const pop = document.querySelector('#button');
const container = document.querySelector('.container1');

pop.addEventListener('click', () => {
    // container.classList.toggle('opacity');
    // poped.classList.toggle('positioning');
    container.style.opacity = 0.5;
    poped.style.top = '35%';
});



