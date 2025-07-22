const userTableBody = document.getElementById("user-table-body");

fetch("http://localhost:8080/api/Mieter") // Your Spring Boot endpoint
  .then(response => {
    if (!response.ok) {
      throw new Error("Fehler beim Laden der Benutzerdaten");
    }
    return response.json();
  })
  .then(data => {
    userTableBody.innerHTML = ""; // clear existing content
    data.forEach(user => {
      const admin = user.admin === true ? "Admin": "Verein";  
      
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>#${user.id}</td>
        <td>${user.username}</td>
        <td>${user.passwort}</td>
        <td>${admin}</td>
        <td><button class="table-btn">Bearbeiten</button></td>
      `;
      userTableBody.appendChild(row);
    });
  })
  .catch(error => {
    console.error("Fehler beim Abrufen der Benutzer:", error);
  });
