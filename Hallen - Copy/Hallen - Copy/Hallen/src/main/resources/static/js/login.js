document.getElementById('login-form').addEventListener('submit', function(event) {
  event.preventDefault();

  const username = document.getElementById('username').value;
  const passwort = document.getElementById('password').value;

  fetch('/api/Mieter/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ username, passwort })
  })
  .then(async response => {
    const messageDiv = document.getElementById('login-message');

    if (response.ok) {
      const data = await response.json();
      const token = data.token;
      const isAdmin = data.isAdmin;

      // 🧠 Save everything
      localStorage.setItem('token', token);
      localStorage.setItem('username', username);
      localStorage.setItem('isAdmin', isAdmin); // optional, if you want to use it later

      messageDiv.textContent = 'Login erfolgreich';
      messageDiv.style.color = 'green';

      // 🔀 Redirect based on role
      if (isAdmin) {
        window.location.href = 'index.html'; // 🔐 your admin dashboard
      } else {
        window.location.href = 'verein.html'; // 👤 normal user home
      }
    } else {
      const text = await response.text();
      messageDiv.textContent = text;
      messageDiv.style.color = 'red';
    }
  })
  .catch(error => {
    console.error('Fehler:', error);
  });
});
