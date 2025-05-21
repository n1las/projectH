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
    const text = await response.text();
    const messageDiv = document.getElementById('login-message');

    if (response.ok) {
      messageDiv.textContent = text; // z.B. "Login erfolgreich"
      messageDiv.style.color = 'green';
      // hier kannst du z.B. weiterleiten
    } else {
      messageDiv.textContent = text; // z.B. "Falsches Passwort"
      messageDiv.style.color = 'red';
    }
  })
  .catch(error => {
    console.error('Fehler:', error);
  });
});
