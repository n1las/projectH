window.addEventListener('DOMContentLoaded', () => {
  const token = localStorage.getItem('token');
  if (token) {
    // Optionally verify token expiry on client (or just assume logged in)

    // Hide login button
    const loginBtn = document.getElementById('login-button'); // adjust selector
    if (loginBtn) loginBtn.style.display = 'none';

    // Show logout button or user info if you want
    const logoutBtn = document.getElementById('logout-button');
    if (logoutBtn) logoutBtn.style.display = 'block';
  }
});
async function loadImage() {
    try {
        const response = await fetch("http://localhost:8080/api/Hallen"); // Calls your API
        const hallen = await response.json();
        
        if (hallen.length > 0 && hallen[0].imageUrl) {
            document.getElementById("image").src = hallen[0].imageUrl; // Show first hall's image
        } else {
            document.getElementById("image").alt = "No image found";
        }
    } catch (error) {
        console.error("Error fetching image:", error);
    }
}

loadImage();