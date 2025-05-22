document.getElementById('login-form').addEventListener('submit', function(event) {
  event.preventDefault();

  const username = document.getElementById('username').value;
  const passwort = document.getElementById('password').value;

  fetch('/api/auth/login', { // <-- neuer Endpunkt
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ username, passwort })
  })
  .then(async response => {
    const messageDiv = document.getElementById('login-message');

    if (response.ok) {
      const data = await response.json(); // <-- JSON lesen
      const token = data.token;

      // Token speichern, z. B. im localStorage
      localStorage.setItem('token', token);

      messageDiv.textContent = 'Login erfolgreich!';
      messageDiv.style.color = 'green';

      // Weiterleitung nach erfolgreichem Login
      window.location.href = '/index.html'; // oder wo du willst
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
