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
      const data = await response.json(); // erwartet JSON mit Token
      const token = data.token;

      // Speichere den Token im localStorage
      localStorage.setItem('token', token);
      localStorage.setItem('username',username);

      messageDiv.textContent = 'Login erfolgreich';
      messageDiv.style.color = 'green';

      // Weiterleitung z. B.
      window.location.href = 'index.html';
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