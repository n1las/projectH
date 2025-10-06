const terminTableBody = document.getElementById("termin-table-body");

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
  if (!response.ok) throw new Error("Fehler beim Laden des Hallennamens");
  return await response.text();
}

// 📥 Termine vom Server laden
function loadTermine() {
  fetch("/api/termine/MergedTermine/ForUser")
    .then(response => {
      if (!response.ok) throw new Error("Fehler beim Abrufen der Termine");
      return response.json();
    })
    .then(termine => {
      renderTerminTable(termine);
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

    // 🏟 Hallenname-Zelle
    const hallenNameCell = document.createElement("td");
    hallenNameCell.textContent = "Lädt...";
    row.appendChild(hallenNameCell);

    getHallenName(termin.halleId)
      .then(name => hallenNameCell.textContent = name)
      .catch(() => hallenNameCell.textContent = "Fehler");

    // Anlass
    const anlassCell = document.createElement("td");
    anlassCell.textContent = termin.anlass;
    row.appendChild(anlassCell);

    // Anfang
    const anfangCell = document.createElement("td");
    anfangCell.textContent = anfangFormatted;
    row.appendChild(anfangCell);

    // Ende
    const endeCell = document.createElement("td");
    endeCell.textContent = endeFormatted;
    row.appendChild(endeCell);

    // Anzahl Felder
    const felderCell = document.createElement("td");
    felderCell.textContent = termin.anzahlFelder;
    row.appendChild(felderCell);

    // Absagen-Button
    const deleteCell = document.createElement("td");
    const deleteBtn = document.createElement("button");
    deleteBtn.className = "table-btn delete-btn";
    deleteBtn.setAttribute("data-ids", termin.terminIds.join(","));
    deleteBtn.textContent = "Absagen";
    deleteCell.appendChild(deleteBtn);
    row.appendChild(deleteCell);

    // Bestätigen-Button
    const confirmCell = document.createElement("td");
    const confirmBtn = document.createElement("button");
    confirmBtn.className = "table-btn confirm-btn";
    confirmBtn.setAttribute("data-ids", termin.terminIds.join(","));
    confirmBtn.textContent = "Bestätigen";
    confirmCell.appendChild(confirmBtn);
    row.appendChild(confirmCell);

    terminTableBody.appendChild(row);
  });

  // ✅ Termin bestätigen
// ✅ Button-Events für Test :^)
// ✅ Button-Events für CoCRequest mit nur einem Endpoint
// ✅ Button-Events für CoCRequest mit List<Long>
document.querySelectorAll(".confirm-btn").forEach(button => {
  button.addEventListener("click", () => {
    const ids = button.getAttribute("data-ids")
      .split(",")
      .map(id => Number(id)); // IDs als Number -> JSON Array of Long

    console.log("Bestätigen gedrückt für TerminIds:", ids);

    const sicher = confirm("Bist du sicher, dass du diesen Termin bestätigen möchtest?");
    if (!sicher) return;

    const body = {
      terminIds: ids,
      status: "confirmed"
    };

    fetch("/api/termine/CoC", {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    })
      .then(response => {
        if (!response.ok) throw new Error("Fehler beim Bestätigen");
        console.log("Bestätigung erfolgreich!");
        loadTermine();
      })
      .catch(error => console.error("Fehler beim Bestätigen:", error));
  });
});

document.querySelectorAll(".delete-btn").forEach(button => {
  button.addEventListener("click", () => {
    const ids = button.getAttribute("data-ids")
      .split(",")
      .map(id => Number(id)); // IDs als Number -> JSON Array of Long

    console.log("Absagen gedrückt für TerminIds:", ids);

    const sicher = confirm("Bist du sicher, dass du diesen Termin absagen möchtest?");
    if (!sicher) return;

    const body = {
      terminIds: ids,
      status: "cancelled"
    };

    fetch("/api/termine/CoC", {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body)
    })
      .then(response => {
        if (!response.ok) throw new Error("Fehler beim Absagen");
        console.log("Absage erfolgreich!");
        loadTermine();
      })
      .catch(error => console.error("Fehler beim Absagen:", error));
  });
});


}

// 🚀 Direkt beim Laden ausführen
loadTermine();
