window.addEventListener('DOMContentLoaded', () => {
  // --- LOGIN / LOGOUT BUTTON ---
  const token = localStorage.getItem('token');
  const loginBtn = document.getElementById('login-button');

  // Note: check if its still needed 
  if (loginBtn) {
    if (token) {
      // Change button to "LOGOUT"
      loginBtn.textContent = 'LOGOUT';
      loginBtn.addEventListener('click', () => {
        localStorage.removeItem('token');
        localStorage.removeItem('username');
        localStorage.removeItem('isAdmin');
        window.location.href = '/home'; // Redirect after logout
      });
    } else {
      // Redirect to login
      loginBtn.addEventListener('click', () => {
        window.location.href = '/login';
      });
    }
  }

});
