const userTableBody = document.getElementById("user-table-body");

fetch("http://localhost:8080/api/Mieter")
  .then(response => {
    if (!response.ok) {
      throw new Error("Fehler beim Laden der Benutzerdaten");
    }
    return response.json();
  })
  .then(data => {
    userTableBody.innerHTML = ""; // clear existing content

    data.forEach(user => {
      const admin = user.admin === true ? "Admin" : "Verein";

      const row = document.createElement("tr");
      row.innerHTML = `
        <td>#${user.id}</td>
        <td>${user.username}</td>
        <td>${user.passwort}</td>
        <td>${admin}</td>
        <td>
          <button class="table-btn edit-btn" data-id="${user.id}">Bearbeiten</button>
        </td>
        <td>
          <button class="table-btn delete-btn" data-id="${user.id}">Löschen</button>
        </td>
      `;
      userTableBody.appendChild(row);
    });

    // Add event listeners for all "Bearbeiten" buttons
    const editButtons = document.querySelectorAll(".edit-btn");
    editButtons.forEach(button => {
      button.addEventListener("click", () => {
        const userId = button.getAttribute("data-id");
        window.location.href = `/editUser/${userId}`;
      });
    });
  })
  .catch(error => {
    console.error("Fehler beim Abrufen der Benutzer:", error);
  });

const newUserButton = document.getElementById("nu-btn");
if (newUserButton) {
  newUserButton.addEventListener("click", () => {
    window.location.href = "/signup";
  });
}

  
