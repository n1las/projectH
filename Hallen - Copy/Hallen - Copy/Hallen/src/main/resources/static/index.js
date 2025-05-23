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

    const username = localStorage.getItem('username');
    console.log('username:', username);
  }
});
