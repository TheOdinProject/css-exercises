const checkbox = document.getElementById('checkbox');
const sidebar = document.getElementById('sidebar');
// const span = document.getElementsByTagName('span');

checkbox.addEventListener('change', function () {
    if (this.checked) {
        sidebar.classList.add('translate');
    } else {
        sidebar.classList.remove('translate');
    }
}
);

const anchor = document.getElementsByTagName("a");

for (let i = 0; i < anchor.length; i++) {
    anchor[i].addEventListener('click', function (e) {
        e.preventDefault();
    });
}