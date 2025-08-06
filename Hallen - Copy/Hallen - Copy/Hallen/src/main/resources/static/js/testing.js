const terminTableBody = document.getElementById("termin-table-body");
const mieterId = 32; // z. B. aus Session oder URL
const confirmed = "unconfirmed"; // oder "false" für unbestätigte

fetch(`http://localhost:8080/api/termine/getByMieterIdAndConfirmed/${mieterId}/${confirmed}`)
  .then(response => {
    if (!response.ok) {
      throw new Error("Fehler beim Laden der Termine");
    }
    return response.json();
  })
  .then(data => {
    terminTableBody.innerHTML = ""; // Tabelle leeren

    data.forEach(termin => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>#${termin.hallenId}</td>
        <td>${termin.anlass}</td>
        <td>${termin.anfang}</td>
        <td>${termin.ende}</td>

      `;
      terminTableBody.appendChild(row);
    });
  })
  .catch(error => {
    console.error("Fehler beim Abrufen der Termine:", error);
  });
