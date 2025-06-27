window.addEventListener('DOMContentLoaded', () => {
  const token = localStorage.getItem('token');
  const loginBtn = document.getElementById('login-button');

  if (token && loginBtn) {
    // Change button to "LOGOUT"
    loginBtn.textContent = 'LOGOUT';
    loginBtn.addEventListener('click', () => {
      // Clear token and redirect
      localStorage.removeItem('token');
      localStorage.removeItem('username');
      localStorage.removeItem('isAdmin');
      window.location.href = '/home'; // or wherever you want to redirect
    });
  } else if (loginBtn) {
    // If not logged in, make the button go to login page
    loginBtn.addEventListener('click', () => {
      window.location.href = '/login';
    });
  }
});
