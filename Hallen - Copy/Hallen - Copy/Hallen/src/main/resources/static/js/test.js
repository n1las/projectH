// editTermin.js
document.addEventListener("DOMContentLoaded", () => {
  const termin = JSON.parse(localStorage.getItem("editTermin"));

  if (!termin) {
    alert("Kein Termin im Speicher gefunden!");
    return;
  }

  // Felder füllen
  document.getElementById("anlass").value = termin.anlass || "";

  if (termin.anfang) {
    document.getElementById("anfang").value = termin.anfang.slice(0, 16); // ISO → datetime-local
  }

  if (termin.ende) {
    document.getElementById("ende").value = termin.ende.slice(0, 16);
  }

  document.getElementById("mieter").value = termin.mieterId || "";

  // Halle-Select füllen
  const halleSelect = document.getElementById("halle");
  halleSelect.innerHTML = ""; // Reset

  if (termin.feldIds && termin.feldIds.length > 0) {
    termin.feldIds.forEach(feldId => {
      const option = document.createElement("option");
      option.value = feldId;
      option.textContent = `Feld ${feldId}`;
      option.selected = true;
      halleSelect.appendChild(option);
    });
  } else {
    const option = document.createElement("option");
    option.textContent = "Keine Halle ausgewählt";
    option.disabled = true;
    halleSelect.appendChild(option);
  }

  // Status-Select füllen
  const statusSelect = document.getElementById("status");
  statusSelect.innerHTML = "";

  const statuses = ["true", "false"];
  statuses.forEach(s => {
    const option = document.createElement("option");
    option.value = s;
    option.textContent = s === "true" ? "Bestätigt" : "Offen";
    if (String(termin.confirmed) === s) {
      option.selected = true;
    }
    statusSelect.appendChild(option);
  });

  // Event Listener: Formular speichern
  document.getElementById("edit-termin-form").addEventListener("submit", (e) => {
    e.preventDefault();

    const updatedTermin = {
      terminIds: termin.terminIds,
      feldIds: Array.from(halleSelect.selectedOptions).map(opt => parseInt(opt.value, 10)),
      anlass: document.getElementById("anlass").value,
      anfang: document.getElementById("anfang").value,
      ende: document.getElementById("ende").value,
      mieterId: document.getElementById("mieter").value,
      confirmed: document.getElementById("status").value === "true"
    };

    console.log("Aktualisierte Daten:", updatedTermin);

    // TODO: API-Call einbauen
    // fetch("http://localhost:8080/api/termine/update", { ... })
  });

  // Abbrechen Button → zurück zur Übersicht
  document.querySelector(".cancel").addEventListener("click", () => {
    window.location.href = "/";
  });
});
