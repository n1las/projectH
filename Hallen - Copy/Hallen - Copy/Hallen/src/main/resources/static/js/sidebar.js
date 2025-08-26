const toggleBtn = document.getElementById("sidebar-button");
const sidebar = document.getElementById("sidebar");
const container = document.querySelector(".container");

toggleBtn.addEventListener("click", () => {
  sidebar.classList.toggle("hidden");
  container.classList.toggle("sidebar-visible");
});
document.getElementById('exportLi').addEventListener('click', () => {
    window.location.href = '/api/termineExport/export/excel';
});