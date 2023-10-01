const accordian=document.querySelectorAll(".accordian")

accordian.forEach(accordian =>{
    const icon=accordian.querySelector('.icon')
    const answer=accordian.querySelector('.answer')

    accordian.addEventListener('click', () =>{
        icon.classList.toggle('active')
        answer.classList.toggle('active')
    })
})