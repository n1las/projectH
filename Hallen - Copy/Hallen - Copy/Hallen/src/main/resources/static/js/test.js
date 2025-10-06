// editTermin.js
document.addEventListener("DOMContentLoaded", () => {
  const termin = JSON.parse(localStorage.getItem("editTermin"));

  if (!termin) {
    alert("Kein Termin im Speicher gefunden!");
    return;
  }

  // --- Input Refs ---
  const anlassInput = document.getElementById("anlass");
  const anfangInput = document.getElementById("anfang");
  const endeInput = document.getElementById("ende");
  const mieterInput = document.getElementById("mieter"); // shows name now
  const statusSelect = document.getElementById("status");

  // --- Felder füllen ---
  anlassInput.value = termin.anlass || "";

  if (termin.anfang) {
    anfangInput.value = termin.anfang.slice(0, 16);
  }
  if (termin.ende) {
    endeInput.value = termin.ende.slice(0, 16);
  }

  // --- Mietername laden ---
  if (termin.mieterId) {
    fetch(`/api/Mieter/${termin.mieterId}`)
      .then(res => {
        if (!res.ok) throw new Error("Mieter konnte nicht geladen werden");
        return res.json();
      })
      .then(mieter => {
        mieterInput.value = mieter.username || "";
      })
      .catch(err => {
        console.error("Fehler beim Laden des Mieters:", err);
        mieterInput.value = "";
      });
  }

  // --- Status setzen ---
  if (termin.status) {
    statusSelect.value = termin.status;
  }

  // --- Formular speichern ---
  document.getElementById("edit-termin-form").addEventListener("submit", async (e) => {
    e.preventDefault();

    const requestBody = {
      ids: termin.terminIds,
      anlass: anlassInput.value,
      anfang: anfangInput.value,
      ende: endeInput.value,
      mieterName: mieterInput.value,   // now the name, not the id
      status: statusSelect.value
    };

    console.log("Sending request:", requestBody);

    try {
      const res = await fetch("/api/termine/editTermin", {
        method: "PUT",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(requestBody)
      });

      if (!res.ok) {
        throw new Error("Update fehlgeschlagen: " + res.status);
      }

      const updated = await res.json();
      console.log("Server-Antwort:", updated);

      // window.location.href = "/";
    } catch (err) {
      console.error("Fehler beim Speichern:", err);
      alert("Speichern fehlgeschlagen!");
    }
  });

  // --- Abbrechen Button ---
  document.querySelector(".cancel").addEventListener("click", () => {
    window.location.href = "/";
  });
});
