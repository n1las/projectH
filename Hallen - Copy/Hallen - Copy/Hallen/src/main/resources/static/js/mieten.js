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

  const anzahlFelderSelect = document.getElementById("anzahlFelderDiv");
  const feldButtonsContainer = document.getElementById("feldButtonsContainer");
  let selectedFeldIds = []; // IDs der ausgewählten Felder

  form.addEventListener("submit", (e) => e.preventDefault());

  if (!hallenId) {
    console.error("Keine Hallen-ID gefunden.");
    statusText.textContent = "❌ Keine Halle ausgewählt!";
    return;
  }

  // 🏟️ Halle abfragen und Select ggf. anzeigen
  (async () => {
    try {
      const res = await fetch(`http://localhost:8080/api/Hallen/${hallenId}`);
      if (!res.ok) throw new Error("Halle konnte nicht geladen werden");
      const halle = await res.json();

      if (halle.hallenTyp > 1) {
        anzahlFelderSelect.style.display = "block";
      } else {
        anzahlFelderSelect.style.display = "none";
      }
    } catch (e) {
      console.error("Fehler beim Laden der Halle:", e);
      anzahlFelderSelect.style.display = "none";
    }
  })();

  // 🧩 Umschalten der Input-Gruppen
  terminTyp.addEventListener("change", () => {
    if (terminTyp.value === "einzel") {
      einzelInputs.style.display = "block";
      commonInput.style.display = "block";
      serieInputs.style.display = "none";
      deleteInputs.style.display = "none";
    } else if (terminTyp.value === "block") {
      einzelInputs.style.display = "block";
      commonInput.style.display = "none";
      serieInputs.style.display = "none";
      deleteInputs.style.display = "none";
    } else if (terminTyp.value === "serie") {
      einzelInputs.style.display = "none";
      commonInput.style.display = "block";
      serieInputs.style.display = "block";
      deleteInputs.style.display = "none";
    } else if (terminTyp.value === "delete") {
      einzelInputs.style.display = "none";
      commonInput.style.display = "none";
      serieInputs.style.display = "none";
      deleteInputs.style.display = "block";
    }
  });

  // 📅 Kalender anzeigen
  let calendar;
  if (calendarEl) {
    calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: "dayGridMonth",
      locale: "de",
      headerToolbar: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,timeGridWeek,timeGridDay",
      },
      events: function (fetchInfo, successCallback, failureCallback) {
        fetch("http://localhost:8080/api/termine")
          .then((res) => res.json())
          .then((data) => {
            const filtered = data
              .filter((e) => e.hallenId == hallenId)
              .map((e) => {
                let backgroundColor = "gray";
                let borderColor = "gray";
                let textColor = "white";

                switch (e.confirmed) {
                  case "confirmed":
                    backgroundColor = "green";
                    borderColor = "green";
                    break;
                  case "unconfirmed":
                    backgroundColor = "gold";
                    borderColor = "gold";
                    textColor = "black";
                    break;
                  case "expired":
                    backgroundColor = "red";
                    borderColor = "red";
                    break;
                }

                return {
                  title: e.anlass,
                  start: e.anfang,
                  end: e.ende,
                  backgroundColor,
                  borderColor,
                  textColor,
                };
              });
            successCallback(filtered);
          })
          .catch((err) => failureCallback(err));
      },
    });
    calendar.render();
  }

  // 📤 Formular absenden
  rentBtn.addEventListener("click", async () => {
    statusText.textContent = "";

    const typ = terminTyp.value;

    if (typ === "einzel") {
      const username = form.querySelector("input[name='username']").value.trim();
      const anlass = form.querySelector("input[name='anlassEinzel']").value.trim();
      const anfang = form.querySelector("input[name='anfangEinzel']").value;
      const ende = form.querySelector("input[name='endeEinzel']").value;

      if (!username || !anlass || !anfang || !ende || selectedFeldIds.length === 0) {
        statusText.textContent = "❌ Bitte alle Felder und mindestens ein Feld auswählen.";
        return;
      }

      // 🧍 Mieter-ID laden
      const userResponse = await fetch(`http://localhost:8080/api/Mieter/byUsername/${username}`);
      if (!userResponse.ok) {
        statusText.textContent = "❌ Benutzer nicht gefunden.";
        return;
      }
      const userData = await userResponse.json();
      const mieterId = userData.id;

      const rentData = {
        hallenId: parseInt(hallenId),
        mieterId: mieterId,
        anlass: anlass,
        anfang: anfang,
        ende: ende,
        feldIds: selectedFeldIds, // <-- hier mitgeben
      };

      const post = await fetch("http://localhost:8080/api/termine/mieten/multipleFelder", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(rentData),
      });

      if (post.ok) {
        statusText.textContent = "✅ Einzeltermin erfolgreich erstellt!";
        form.reset();
        selectedFeldIds = [];
        feldButtonsContainer.querySelectorAll(".feld-button.selected").forEach(btn => btn.classList.remove("selected"));
        calendar?.refetchEvents();
      } else {
        statusText.textContent = "❌ Fehler beim Speichern.";
      }
    } 
    else if (typ === "serie") {
      const anfangDatum = form.querySelector("input[name='serieAnfang']").value;
      const endeDatum = form.querySelector("input[name='serieEnde']").value;
      const anfangUhr = form.querySelector("input[name='anfangSerie']").value;
      const endeUhr = form.querySelector("input[name='endeSerie']").value;
      const wochentag = form.querySelector("select[name='wochentag']").value;
      const anlass = form.querySelector("input[name='anlassSerie']").value;
      const username = form.querySelector("input[name='username']").value.trim();

      if (!anfangDatum || !endeDatum || !anfangUhr || !endeUhr || !wochentag || !anlass || !username) {
        statusText.textContent = "❌ Bitte alle Felder ausfüllen Serie bro.";
        return;
      }

      const userResponse = await fetch(`http://localhost:8080/api/Mieter/byUsername/${username}`);
      if (!userResponse.ok) {
        statusText.textContent = "❌ Benutzer nicht gefunden.";
        return;
      }
      const userData = await userResponse.json();
      const mieterId = userData.id;

      const serienTerminData = {
        hallenId: hallenId,
        mieterId: mieterId,
        anlass: anlass,
        serieAnfang: anfangDatum,
        serieEnde: endeDatum,
        anfang: anfangUhr,
        ende: endeUhr,
        wochentag: wochentag,
      };

      const post = await fetch("http://localhost:8080/api/termine/serienTermin", {
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
    }
    else if (typ === "block") {
      const anlass = form.querySelector("input[name='anlassEinzel']").value.trim();
      const anfang = form.querySelector("input[name='anfangEinzel']").value;
      const ende = form.querySelector("input[name='endeEinzel']").value;

      if (!anlass || !anfang || !ende) {
        statusText.textContent = "❌ Bitte alle Block-Felder ausfüllen.";
        return;
      }

      const blockTimeData = {
        hallenId: parseInt(hallenId),
        anlass: anlass,
        anfang: anfang,
        ende: ende,
      };

      const post = await fetch("http://localhost:8080/api/termine/blockTermin", {
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
    else if (typ === "delete") {
      const anfang = form.querySelector("input[name='anfangDelete']").value;

      if (!anfang) {
        statusText.textContent = "❌ Bitte Anfangsdatum angeben.";
        return;
      }

      const post = await fetch(`http://localhost:8080/api/termine/delete/${hallenId}/${anfang}`, {
        method: "DELETE",
      });

      if (post.ok) {
        statusText.textContent = "✅ Termin gelöscht!";
        form.reset();
        calendar?.refetchEvents();
      } else {
        statusText.textContent = "❌ Fehler beim Löschen.";
      }
    }
  });

  // 🎛️ Feld-Buttons erstellen (bei Auswahl Anzahl Felder)
  anzahlFelderSelect.addEventListener("change", () => {
    feldButtonsContainer.innerHTML = "";
    selectedFeldIds = [];
    const count = parseInt(anzahlFelderSelect.value);
    for (let i = 1; i <= count; i++) {
      const btn = document.createElement("button");
      btn.type = "button";
      btn.textContent = `Feld ${i}`;
      btn.classList.add("feld-button");
      btn.addEventListener("click", () => {
        btn.classList.toggle("selected");
        const id = i;
        if (selectedFeldIds.includes(id)) {
          selectedFeldIds = selectedFeldIds.filter((x) => x !== id);
        } else {
          selectedFeldIds.push(id);
        }
      });
      feldButtonsContainer.appendChild(btn);
    }
  });
});
