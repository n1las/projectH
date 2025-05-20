
  document.querySelector('form').addEventListener('submit', function(event) {
    event.preventDefault(); // prevent normal form submission

    const form = event.target;

    // Collect input values
    const mieterData = {
      username: form.querySelector('input[placeholder="Benutzername"]').value,
      email: form.querySelector('input[placeholder="E-Mail"]').value,
      passwort: form.querySelector('input[placeholder="Passwort"]').value,
      name: form.querySelector('input[placeholder="Vorname"]').value,
      nachName: form.querySelector('input[placeholder="Nachname"]').value,
      tel: form.querySelector('input[placeholder="Telefonnummer"]').value
    };

    fetch('/api/Mieter', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(mieterData)
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Netzwerkantwort war nicht ok');
      }
      return response.json();
    })
    .then(data => {
      alert('Registrierung erfolgreich!');
      // Optionally redirect or clear form here
      form.reset();
    })
    .catch(error => {
      console.error('Fehler bei der Registrierung:', error);
      alert('Fehler bei der Registrierung, bitte erneut versuchen.');
    });
  });
