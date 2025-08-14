document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("terminForm");
  const terminTyp = document.getElementById("terminTyp");
  const einzelInputs = document.getElementById("einzelInputs");
  const commonInput = document.getElementById("commonInput");
  const serieInputs = document.getElementById("serieInputs");
  const statusText = document.getElementById("mieten-status");
  const calendarEl = document.getElementById("calendar");
  const hallenId = localStorage.getItem("selectedSubsiteId");
  const rentBtn = document.getElementById("rent-btn");

  let selectedFeldIds = []; // Speicherung ausgewählter Felder

  form.addEventListener("submit", (e) => e.preventDefault());

  if (!hallenId) {
    console.error("Keine Hallen-ID gefunden.");
    statusText.textContent = "❌ Keine Halle ausgewählt!";
    return;
  }

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

      if (!username || !anlass || !anfang || !ende) {
        statusText.textContent = "❌ Bitte alle Felder ausfüllen.";
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

      // 📦 Daten für neuen Endpoint
      const rentData = {
        feldIds: selectedFeldIds,
        mieterId: mieterId,
        anlass: anlass,
        anfang: anfang,
        ende: ende
      
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
        feldIds: selectedFeldIds // ⬅️ hier neu
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
        selectedFeldIds = [];
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
        feldIds: selectedFeldIds // ⬅️ hier neu
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
        selectedFeldIds = [];
      } else {
        statusText.textContent = "❌ Fehler beim Speichern des Blocks.";
      }
    }

    else if (typ === "delete") {
      const anfang = form.querySelector("input[name='anfangDelete']").value;

      if (!anfang) {
        statusText.textContent = "❌ Bitte Startzeitpunkt eingeben.";
        return;
      }

      const deleteUrl = `http://localhost:8080/api/termine/delete?hallenId=${hallenId}&anfang=${encodeURIComponent(anfang)}`;

      const response = await fetch(deleteUrl, { method: "DELETE" });

      if (response.ok) {
        statusText.textContent = "✅ Termin erfolgreich gelöscht!";
        form.reset();
        calendar?.refetchEvents();
      } else {
        statusText.textContent = "❌ Fehler beim Löschen.";
      }
    }
  });

  // 🏟 Feld-Buttons laden
  const anzahlFelderSelect = document.getElementById("anzahlFelder");
  const feldButtonsContainer = document.getElementById("feldButtonsContainer");

  anzahlFelderSelect.addEventListener("change", async () => {
    feldButtonsContainer.innerHTML = "";
    selectedFeldIds = [];

    if (anzahlFelderSelect.value === "einzeln") {
      try {
        const res = await fetch(`http://localhost:8080/api/feld/getByHallenId/${hallenId}`);
        if (!res.ok) throw new Error("Felder konnten nicht geladen werden");

        const felder = await res.json();

        felder.forEach((feld) => {
          const btn = document.createElement("button");
          btn.type = "button";
          btn.textContent = feld.name;
          btn.className = "feld-button";
          btn.style.marginRight = "8px";
          btn.dataset.feldId = feld.id;
          btn.dataset.feldName = feld.name;

          btn.addEventListener("click", () => {
            const feldId = btn.dataset.feldId;

            btn.classList.toggle("selected");

            if (btn.classList.contains("selected")) {
              if (!selectedFeldIds.includes(feldId)) {
                selectedFeldIds.push(feldId);
              }
            } else {
              selectedFeldIds = selectedFeldIds.filter(id => id !== feldId);
            }

            console.log("Aktuell ausgewählte Feld-IDs:", selectedFeldIds);
          });

          feldButtonsContainer.appendChild(btn);
        });
      } catch (e) {
        feldButtonsContainer.textContent = "Fehler beim Laden der Felder.";
        console.error(e);
      }
    }
  });
});
