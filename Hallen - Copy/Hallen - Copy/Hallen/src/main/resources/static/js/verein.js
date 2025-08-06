const terminTableBody = document.getElementById("termin-table-body");
const confirmed = "unconfirmed";
const userTableBody = document.getElementById("user-table-body");

// Load all termine
function loadTermine() {
  fetch("/api/Mieter/me")
    .then(response => {
      if (!response.ok) throw new Error("Fehler beim Abrufen des Mieters");
      return response.json();
    })
    .then(data => {
      const mieterId = data.id;
      return fetch(`/api/termine/getByMieterIdAndConfirmed/${mieterId}/${confirmed}`);
    })
    .then(response => {
      if (!response.ok) throw new Error("Fehler beim Laden der Termine");
      return response.json();
    })
    .then(data => {
      renderTerminTable(data);
    })
    .catch(error => {
      console.error("Fehler beim Abrufen der Daten:", error);
    });
}

// Render rows + attach event listeners
function renderTerminTable(termine) {
  terminTableBody.innerHTML = "";

  termine.forEach(termin => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>#${termin.hallenId}</td>
      <td>${termin.anlass}</td>
      <td>${termin.anfang}</td>
      <td>${termin.ende}</td>
      <td>
        <button class="table-btn confirm-btn" data-id="${termin.id}">Bestätigen</button>
      </td>
      <td>
        <button class="table-btn delete-btn" data-id="${termin.id}">Absagen</button>
      </td>
    `;
    terminTableBody.appendChild(row);
  });

  // 🔘 Confirm button logic
  document.querySelectorAll(".confirm-btn").forEach(button => {
    button.addEventListener("click", () => {
      const terminId = button.getAttribute("data-id");
      const sicher = confirm("Bist du sicher, dass du diesen Termin bestätigen möchtest?");
      if (!sicher) return;

      fetch(`/api/termine/${terminId}/confirm`, { method: "PATCH" })
        .then(response => {
          if (!response.ok) throw new Error("Fehler beim Bestätigen");
          loadTermine(); // reload list
        })
        .catch(error => {
          console.error("Fehler beim Bestätigen:", error);
        });
    });
  });

  // ❌ Delete button logic
  document.querySelectorAll(".delete-btn").forEach(button => {
    button.addEventListener("click", () => {
      const terminId = button.getAttribute("data-id");
      const sicher = confirm("Bist du sicher, dass du diesen Termin absagen möchtest?");
      if (!sicher) return;

      fetch(`/api/termine/${terminId}`, { method: "DELETE" })
        .then(response => {
          if (!response.ok) throw new Error("Fehler beim Löschen");
          loadTermine(); // reload list
        })
        .catch(error => {
          console.error("Fehler beim Löschen:", error);
        });
    });
  });
}

// Initial load
loadTermine();
