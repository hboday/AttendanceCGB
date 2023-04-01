// slidebar.js
document.addEventListener("DOMContentLoaded", () => {
    const toggleSlidebarBtn = document.getElementById("toggle-slidebar");
    const slidebar = document.getElementById("slidebar");

    toggleSlidebarBtn.addEventListener("click", () => {
        slidebar.classList.toggle("open");

        if (slidebar.classList.contains("open")) {
            toggleSlidebarBtn.textContent = "Close Notifications";
        } else {
            toggleSlidebarBtn.textContent = "Open Notifications";
        }
    });
});