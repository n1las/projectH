const terminTableBody = document.getElementById("termin-table-body");
const confirmed = "unconfirmed";
const userTableBody = document.getElementById("user-table-body");

// 🕓 Hilfsfunktion: ISO-Datum → deutsches Format
function formatGermanDate(isoDateString) {
  const date = new Date(isoDateString);
  return date.toLocaleString('de-DE', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  }) + ' Uhr';
}

async function getHallenName(id) {
  const response = await fetch(`/api/Hallen/getName/${id}`);
  if (!response.ok) {
    throw new Error("Fehler beim Laden des Hallennamens");
  }
  return await response.text();
}

// 📥 Termine vom Server laden
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

// 📊 Tabelle befüllen & Event Listener anhängen
function renderTerminTable(termine) {
  terminTableBody.innerHTML = "";

  termine.forEach(termin => {
    const anfangFormatted = formatGermanDate(termin.anfang);
    const endeFormatted = formatGermanDate(termin.ende);

    const row = document.createElement("tr");

    // 🏟 Hallenname-Zelle mit Platzhalter
    const hallenNameCell = document.createElement("td");
    hallenNameCell.textContent = "Lädt...";
    row.appendChild(hallenNameCell);

    // 📡 Hole den Hallennamen asynchron und setze ihn in die Zelle
    getHallenName(termin.hallenId)
      .then(name => {
        hallenNameCell.textContent = name;
      })
      .catch(() => {
        hallenNameCell.textContent = "Fehler";
      });

    // Andere Zellen erstellen und anhängen
    const anlassCell = document.createElement("td");
    anlassCell.textContent = termin.anlass;
    row.appendChild(anlassCell);

    const anfangCell = document.createElement("td");
    anfangCell.textContent = anfangFormatted;
    row.appendChild(anfangCell);

    const endeCell = document.createElement("td");
    endeCell.textContent = endeFormatted;
    row.appendChild(endeCell);

    // Absagen-Button
    const deleteCell = document.createElement("td");
    const deleteBtn = document.createElement("button");
    deleteBtn.className = "table-btn delete-btn";
    deleteBtn.setAttribute("data-id", termin.id);
    deleteBtn.textContent = "Absagen";
    deleteCell.appendChild(deleteBtn);
    row.appendChild(deleteCell);

    // Bestätigen-Button
    const confirmCell = document.createElement("td");
    const confirmBtn = document.createElement("button");
    confirmBtn.className = "table-btn confirm-btn";
    confirmBtn.setAttribute("data-id", termin.id);
    confirmBtn.textContent = "Bestätigen";
    confirmCell.appendChild(confirmBtn);
    row.appendChild(confirmCell);

    terminTableBody.appendChild(row);
  });

  // ✅ Termin bestätigen
  document.querySelectorAll(".confirm-btn").forEach(button => {
    button.addEventListener("click", () => {
      const terminId = button.getAttribute("data-id");
      const sicher = confirm("Bist du sicher, dass du diesen Termin bestätigen möchtest?");
      if (!sicher) return;

      fetch(`/api/termine/${terminId}/confirm`, { method: "PATCH" })
        .then(response => {
          if (!response.ok) throw new Error("Fehler beim Bestätigen");
          loadTermine();
        })
        .catch(error => {
          console.error("Fehler beim Bestätigen:", error);
        });
    });
  });

  // ❌ Termin absagen
  document.querySelectorAll(".delete-btn").forEach(button => {
    button.addEventListener("click", () => {
      const terminId = button.getAttribute("data-id");
      const sicher = confirm("Bist du sicher, dass du diesen Termin absagen möchtest?");
      if (!sicher) return;

      fetch(`/api/termine/${terminId}/cancel`, { method: "PATCH" })
        .then(response => {
          if (!response.ok) throw new Error("Fehler beim Bestätigen");
          loadTermine();
        })
        .catch(error => {
          console.error("Fehler beim Bestätigen:", error);
        });
    });
  });
}

// 🚀 Direkt beim Laden ausführen
loadTermine();
