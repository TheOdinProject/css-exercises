const fadeInContainer = document.querySelector(".fadein-container");

// When the page loads, trigger the fade-in animation
window.addEventListener("load", () => {
  fadeInContainer.classList.add("visible");
});

// If you want to reset it by clicking anywhere (optional)
window.addEventListener("click", (e) => {
  if (!fadeInContainer.contains(e.target)) {
    fadeInContainer.classList.remove("visible");
    void fadeInContainer.offsetWidth; // Force reflow to restart animation
    fadeInContainer.classList.add("visible");
  }
});
