const terminTableBody = document.getElementById("termin-table-body");

// 🕓 Hilfsfunktion: ISO-Datum → deutsches Format
function formatGermanDate(isoDateString) {
  const date = new Date(isoDateString);
  return date.toLocaleString("de-DE", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  }) + " Uhr";
}

// 📥 Termine vom Server laden
function loadTermine() {
  fetch("http://localhost:8080/api/termine/getMergedTermine")
    .then((response) => {
      if (!response.ok) throw new Error("Fehler beim Abrufen der Termine");
      return response.json();
    })
    .then((termine) => {
      renderTerminTable(termine);
    })
    .catch((error) => {
      console.error("Fehler beim Abrufen der Daten:", error);
    });
}

// 📊 Tabelle befüllen & Event Listener anhängen
function renderTerminTable(termine) {
  terminTableBody.innerHTML = "";

  termine.forEach((termin) => {
    const anfangFormatted = formatGermanDate(termin.anfang);
    const endeFormatted = formatGermanDate(termin.ende);

    const row = document.createElement("tr");

    // Termin Id(s)
    const terminIdCell = document.createElement("td");
    terminIdCell.textContent = termin.terminIds.join(", ");
    row.appendChild(terminIdCell);

    // Feld Id(s)
    const feldIdCell = document.createElement("td");
    feldIdCell.textContent = termin.feldIds.join(", ");
    row.appendChild(feldIdCell);

    // Anfang
    const anfangCell = document.createElement("td");
    anfangCell.textContent = anfangFormatted;
    row.appendChild(anfangCell);

    // Ende
    const endeCell = document.createElement("td");
    endeCell.textContent = endeFormatted;
    row.appendChild(endeCell);

    // Anlass
    const anlassCell = document.createElement("td");
    anlassCell.textContent = termin.anlass;
    row.appendChild(anlassCell);

    // Anzahl Felder (Text, z.B. "Feld 1, Feld 2")
    const felderCell = document.createElement("td");
    felderCell.textContent = termin.anzahlFelder;
    row.appendChild(felderCell);

    // Status
    const statusCell = document.createElement("td");
    statusCell.textContent = termin.confirmed;
    row.appendChild(statusCell);

    // MieterId
    const mieterCell = document.createElement("td");
    mieterCell.textContent = termin.mieterId;
    row.appendChild(mieterCell);

    // Bearbeiten-Button
    const editCell = document.createElement("td");
    const editBtn = document.createElement("button");
    editBtn.className = "table-btn edit-btn";
    editBtn.setAttribute("data-ids", termin.terminIds.join(","));
    editBtn.textContent = "Bearbeiten";
    editCell.appendChild(editBtn);
    row.appendChild(editCell);

    // Löschen-Button
    const deleteCell = document.createElement("td");
    const deleteBtn = document.createElement("button");
    deleteBtn.className = "table-btn delete-btn";
    deleteBtn.setAttribute("data-ids", termin.terminIds.join(","));
    deleteBtn.textContent = "Löschen";
    deleteCell.appendChild(deleteBtn);
    row.appendChild(deleteCell);

    terminTableBody.appendChild(row);
  });

  // 🛠️ Button Events
  document.querySelectorAll(".edit-btn").forEach((button) => {
    button.addEventListener("click", () => {
      const ids = button.getAttribute("data-ids").split(",").map(Number);
      console.log("Bearbeiten gedrückt für TerminIds:", ids);
      alert("Hier könnte dein Bearbeiten-Dialog kommen 😎");
    });
  });

  document.querySelectorAll(".delete-btn").forEach((button) => {
    button.addEventListener("click", () => {
      const ids = button.getAttribute("data-ids").split(",").map(Number);
      console.log("Löschen gedrückt für TerminIds:", ids);

      const sicher = confirm("Bist du sicher, dass du diesen Termin löschen möchtest?");
      if (!sicher) return;

      fetch("http://localhost:8080/api/termine/delete/byIds", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ terminIds: ids}),
      })
        .then((response) => {
          if (!response.ok) throw new Error("Fehler beim Löschen");
          console.log("Termin gelöscht!");
          loadTermine();
        })
        .catch((error) => console.error("Fehler beim Löschen:", error));
    });
  });
}

// 🚀 Direkt beim Laden ausführen
loadTermine();
