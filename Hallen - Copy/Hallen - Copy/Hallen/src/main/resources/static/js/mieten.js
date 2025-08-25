document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("terminForm");
  const terminTyp = document.getElementById("terminTyp");
  const einzelInputs = document.getElementById("einzelInputs");
  const commonInput = document.getElementById("commonInput");
  const serieInputs = document.getElementById("serieInputs");
  const deleteInputs = document.getElementById("deleteInputs");
  const statusText = document.getElementById("mieten-status");
  const calendarEl = document.getElementById("calendar");
  const hallenId = localStorage.getItem("selectedSubsiteId");
  const rentBtn = document.getElementById("rent-btn");
  const felderAuswahlDiv =document.getElementById("felderAuswahlDiv");


  const anzahlFelderSelect = document.getElementById("anzahlFelder"); // nur anzeigen/verstecken
  const feldButtonsContainer = document.getElementById("feldButtonsContainer");

  let selectedFeldIds = []; // hier sammeln wir die ausgewählten Feld-IDs

  form.addEventListener("submit", (e) => e.preventDefault());

  if (!hallenId) {
    console.error("Keine Hallen-ID gefunden.");
    if (statusText) statusText.textContent = "❌ Keine Halle ausgewählt!";
    return;
  }

  // ➜ Halle laden: #anzahlFelder nur anzeigen, wenn hallenTyp > 1
  (async () => {
    try {
      const res = await fetch(`http://localhost:8080/api/Hallen/${hallenId}`);
      if (!res.ok) throw new Error("Halle konnte nicht geladen werden");
      const halle = await res.json();

      if (halle.hallenTyp > 1) {
        felderAuswahlDiv.style.display = "block";
  
        if (anzahlFelderSelect) anzahlFelderSelect.style.display = "block";
        // Buttons direkt aus dem Feld-Endpoint generieren
        await loadFelderAndBuildButtons();

      } else {
        if (anzahlFelderSelect) anzahlFelderSelect.remove(1);
        // wenn keine Mehrfeld-Halle: Buttons wegräumen
        clearFeldButtons();
      }
    } catch (e) {
      console.error("Fehler beim Laden der Halle:", e);
      if (anzahlFelderSelect) anzahlFelderSelect.style.display = "none";
      clearFeldButtons();
    }
  })();

  // Eingabebereiche umschalten
  terminTyp.addEventListener("change", async () => {
    einzelInputs.style.display = "none";
    commonInput.style.display = "none";
    serieInputs.style.display = "none";
    deleteInputs.style.display = "none";

    if (terminTyp.value === "einzel") {
      einzelInputs.style.display = "block";
      commonInput.style.display = "block";
      felderAuswahlDiv.style.display = "block";
      // sicherstellen, dass Feld-Buttons da sind (falls Nutzer erst jetzt auf "einzel" wechselt)
      await loadFelderAndBuildButtons();
    } else if (terminTyp.value === "block") {
      einzelInputs.style.display = "block";
      await loadFelderAndBuildButtons(); // ggf. auch für Block relevant
    } else if (terminTyp.value === "serie") {
      commonInput.style.display = "block";
      serieInputs.style.display = "block";
      felderAuswahlDiv.style.display = "block";
      await loadFelderAndBuildButtons(); // falls Serie auch Felder braucht
    } else if (terminTyp.value === "delete") {
      deleteInputs.style.display = "block";
      felderAuswahlDiv.style.display = "block"
      // Für delete keine Felder nötig
    }
  });
  anzahlFelderSelect.addEventListener("change", async () => {
    feldButtonsContainer.display ="none";

    if (anzahlFelderSelect.value === "einzeln") {
      feldButtonsContainer.display="block";
      feldButtonsContainer.style.display = "block";

    } else if (anzahlFelderSelect.value === "komplett") {
      feldButtonsContainer.style.display ="none";
    }

  });
  
  // ➜ Absenden
  rentBtn.addEventListener("click", async () => {
    if (!statusText) return;
    statusText.textContent = "";

    const typ = terminTyp.value;

    // EINZEL ➜ neuer Endpoint mieten/multipleFelder
    if (typ === "einzel") {
      const username = form.querySelector("input[name='username']").value.trim();
      const anlass = form.querySelector("input[name='anlassEinzel']").value.trim();
      const anfang = form.querySelector("input[name='anfangEinzel']").value;
      const ende = form.querySelector("input[name='endeEinzel']").value;

      if (!username || !anlass || !anfang || !ende || (selectedFeldIds.length === 0 && selectedFeldIds.value === "einzeln")) {
        statusText.textContent = "❌ Bitte alle Felder ausfüllen und mindestens ein Feld auswählen.";
        return;
      }

      // Mieter laden
      const userResponse = await fetch(`http://localhost:8080/api/Mieter/byUsername/${username}`);
      if (!userResponse.ok) {
        statusText.textContent = "❌ Benutzer nicht gefunden.";
        return;
      }
      const userData = await userResponse.json();
      const mieterId = userData.id;
      
      const felderOrHalle = anzahlFelderSelect.value;

      if(felderOrHalle === "komplett"){
        const rentData = {
          halleId: parseInt(hallenId),
          mieterId: mieterId,
          anlass: anlass,
          anfang: anfang,
          ende: ende,
        };

        const post = await fetch("http://localhost:8080/api/termine/mieten/halle", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(rentData),
      });
       if (post.ok) {
        statusText.textContent = "✅ Einzeltermin erfolgreich erstellt!";
        form.reset();
        // Auswahl zurücksetzen
        selectedFeldIds = [];
        if (feldButtonsContainer) {
          feldButtonsContainer.querySelectorAll(".feld-button.selected").forEach(btn => btn.classList.remove("selected"));
        }
        location.href = location.href;
      } else {
        statusText.textContent = "❌ Fehler beim Speichern.";
      }
      }
      else if(felderOrHalle === "einzeln"){
        const rentData = {
        hallenId: parseInt(hallenId),
        mieterId: mieterId,
        anlass: anlass,
        anfang: anfang,
        ende: ende,
        feldIds: selectedFeldIds, // hier die ausgewählten Feld-IDs
      };

      const post = await fetch("http://localhost:8080/api/termine/mieten/multipleFelder", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(rentData),
        
      });
         if (post.ok) {
        statusText.textContent = "✅ Einzeltermin erfolgreich erstellt!";
        form.reset();
        // Auswahl zurücksetzen
        selectedFeldIds = [];
        if (feldButtonsContainer) {
          feldButtonsContainer.querySelectorAll(".feld-button.selected").forEach(btn => btn.classList.remove("selected"));
        }
        location.href = location.href;
      } else {
        statusText.textContent = "❌ Fehler beim Speichern.";
      }
      }

    }

    // SERIE
  else if (typ === "serie") {
    const anfangDatum = form.querySelector("input[name='serieAnfang']").value;
    const endeDatum = form.querySelector("input[name='serieEnde']").value;
    const anfangUhr = form.querySelector("input[name='anfangSerie']").value;
    const endeUhr = form.querySelector("input[name='endeSerie']").value;
    const wochentag = form.querySelector("select[name='wochentag']").value;
    const anlass = form.querySelector("input[name='anlassSerie']").value;
    const username = form.querySelector("input[name='username']").value.trim();

    if (!anfangDatum || !endeDatum || !anfangUhr || !endeUhr || !wochentag || !anlass || !username) {
      statusText.textContent = "❌ Bitte alle Felder ausfüllen (Serie).";
      return;
    }

    const userResponse = await fetch(`http://localhost:8080/api/Mieter/byUsername/${username}`);
    if (!userResponse.ok) {
      statusText.textContent = "❌ Benutzer nicht gefunden.";
      return;
    }
    const userData = await userResponse.json();
    const mieterId = userData.id;

    if (anzahlFelderSelect.value === "komplett") {
      // Original: Halle
      const serienTerminData = {
        halleId: hallenId,
        mieterId: mieterId,
        anlass: anlass,
        serieAnfang: anfangDatum,
        serieEnde: endeDatum,
        anfang: anfangUhr,
        ende: endeUhr,
        wochentag: wochentag,
      };

      const post = await fetch("http://localhost:8080/api/termine/serienTermin/Halle", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(serienTerminData),
      });

      if (post.ok) {
        statusText.textContent = "✅ Serientermin erfolgreich erstellt!";
        form.reset();
        calendar?.refetchEvents();
      } else {
        statusText.textContent = "❌ Fehler beim Serientermin.";
      }
    } else if (anzahlFelderSelect.value === "einzeln") {
      // Use the already existing selectedFeldIds
      if (!selectedFeldIds || selectedFeldIds.length === 0) {
        statusText.textContent = "❌ Bitte mindestens ein Feld auswählen.";
        return;
      }

      const serienTerminData = {
        feldIds: selectedFeldIds,
        mieterId: mieterId,
        anlass: anlass,
        serieAnfang: anfangDatum,
        serieEnde: endeDatum,
        anfang: anfangUhr,
        ende: endeUhr,
        wochentag: wochentag,
      };

      const post = await fetch("http://localhost:8080/api/termine/serienTermin/Felder", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(serienTerminData),
      });

      if (post.ok) {
        statusText.textContent = "✅ Serientermin (einzeln) erfolgreich erstellt!";
        form.reset();
        calendar?.refetchEvents();
      } else {
        statusText.textContent = "❌ Fehler beim Serientermin (einzeln).";
      }
    }
  }


    // BLOCK
    else if (typ === "block") {
      const anlass = form.querySelector("input[name='anlassEinzel']").value.trim();
      const anfang = form.querySelector("input[name='anfangEinzel']").value;
      const ende = form.querySelector("input[name='endeEinzel']").value;

      if (!anlass || !anfang || !ende) {
        statusText.textContent = "❌ Bitte alle Block-Felder ausfüllen.";
        return;
      }

      const blockTimeData = { 
        halleId: parseInt(hallenId),
        anlass: anlass,
        anfang: anfang,
        ende: ende,
      };

      const post = await fetch("http://localhost:8080/api/termine/blockHalle", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(blockTimeData),
      });

      if (post.ok) {
        statusText.textContent = "✅ Block-Zeitraum erfolgreich eingetragen!";
        form.reset();
        calendar?.refetchEvents();
      } else {
        statusText.textContent = "❌ Fehler beim Speichern des Blocks.";
      }
    }

    // DELETE
    else if (typ === "delete") {
      const anfang = form.querySelector("input[name='anfangDelete']").value;

      if (!anfang) {
        statusText.textContent = "❌ Bitte Startzeitpunkt eingeben.";
        return;
      }

 // Prepare the DeleteRequest object
    const DeleteRequest = {
        feldIds: selectedFeldIds,
        start: anfang
    };

    // Make the fetch request
    fetch('http://localhost:8080/api/termine/delete', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(DeleteRequest)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`Error: ${response.status}`);
        }
        return response.text();
    })
    .then(message => {
        console.log(message); // "Termin deleted successfully! 🧹" or "No matching Termin found. ❌"
    })
    .catch(error => {
        console.error('Fetch error:', error);
    });

    }
  });

  // ---------- Hilfsfunktionen ----------

  function clearFeldButtons() {
    if (!feldButtonsContainer) return;
    feldButtonsContainer.innerHTML = "";
    selectedFeldIds = [];
  }

  // Lädt Felder aus dem Backend und erzeugt Buttons (GENAU wie du wolltest)
  async function loadFelderAndBuildButtons() {
    if (!feldButtonsContainer) return;
      try {
        const res = await fetch(`http://localhost:8080/api/feld/getByHallenId/${hallenId}`);

        if (!res.ok) throw new Error("Felder konnten nicht geladen werden");

        const felder = await res.json(); // erwartet: [{ id, name, ... }, ...]
        feldButtonsContainer.innerHTML = "";
        selectedFeldIds = [];

        felder.forEach((feld) => {
          const btn = document.createElement("button");
          btn.type = "button";
          btn.textContent = feld.name ?? `Feld ${feld.id}`;
          btn.className = "feld-button";
          btn.style.marginRight = "8px";

          // ID/Name als data-Attribute
          btn.dataset.feldId = feld.id;
          btn.dataset.feldName = feld.name ?? `Feld ${feld.id}`;

          // Toggle + Array-Management (IDs als Number speichern)
          btn.addEventListener("click", () => {
            btn.classList.toggle("selected");
            const feldIdNum = Number(btn.dataset.feldId);

            if (btn.classList.contains("selected")) {
              if (!selectedFeldIds.includes(feldIdNum)) {
                selectedFeldIds.push(feldIdNum);
              }
            } else {
              selectedFeldIds = selectedFeldIds.filter((id) => id !== feldIdNum);
            }
            // Debug:
            console.log("Aktuell ausgewählte Feld-IDs:", selectedFeldIds);
          });

          feldButtonsContainer.appendChild(btn);
        });

        if (felder.length === 0) {
          const info = document.createElement("div");
          info.textContent = "Keine Felder gefunden.";
          feldButtonsContainer.appendChild(info);
        }
      } catch (e) {
        console.error(e);
        feldButtonsContainer.innerHTML = "Fehler beim Laden der Felder.";
      }
  }
});
