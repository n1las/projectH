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
        window.location.href = `/admin/editUser/${userId}`;
      });
    });
    const deleteButtons = document.querySelectorAll(".delete-btn");

    deleteButtons.forEach(button => {
      button.addEventListener("click", () => {
        const userId = button.getAttribute("data-id");

        if (confirm("Are you sure you want to delete this user?")) {
          fetch(`/api/Mieter/${userId}`, {
            method: 'DELETE'
          })
          .then(response => {
            if (response.ok) {
              alert("User deleted successfully!");
              // Optionally remove the row from the DOM
              button.closest("tr").remove();
            } else {
              alert("Failed to delete user.");
            }
          })
          .catch(error => {
            console.error("Error deleting user:", error);
            alert("An error occurred.");
          });
        }
      });
    });

  })
  .catch(error => {
    console.error("Fehler beim Abrufen der Benutzer:", error);
  });

const newUserButton = document.getElementById("nu-btn");
if (newUserButton) {
  newUserButton.addEventListener("click", () => {
    window.location.href = "/admin/signup";
  });
}

  
