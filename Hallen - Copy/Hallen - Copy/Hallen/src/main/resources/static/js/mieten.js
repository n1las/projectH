document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("terminForm");
  const terminTyp = document.getElementById("terminTyp");
  const einzelInputs = document.getElementById("einzelInputs");
  const serieInputs = document.getElementById("serieInputs");
  const statusText = document.getElementById("mieten-status");
  const calendarEl = document.getElementById("calendar");
  const hallenId = localStorage.getItem("selectedSubsiteId");

  if (!hallenId) {
    console.error("Keine Hallen-ID gefunden.");
    statusText.textContent = "❌ Keine Halle ausgewählt!";
    return;
  }

  // 🧩 Umschalten der Input-Gruppen
  terminTyp.addEventListener("change", () => {
    if (terminTyp.value === "einzel") {
      einzelInputs.style.display = "block";
      serieInputs.style.display = "none";
    } else {
      einzelInputs.style.display = "none";
      serieInputs.style.display = "block";
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
              .map((e) => ({
                title: e.anlass,
                start: e.anfang,
                end: e.ende,
              }));
            successCallback(filtered);
          })
          .catch((err) => failureCallback(err));
      },
    });
    calendar.render();
  }

  // 📤 Formular absenden
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
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

      // ✅ Verfügbarkeit prüfen
      const checkUrl = `http://localhost:8080/api/termine/check?hallenId=${hallenId}&anfang=${encodeURIComponent(anfang)}&ende=${encodeURIComponent(ende)}`;
      const checkResponse = await fetch(checkUrl);
      const isAvailable = await checkResponse.json();

      if (!isAvailable) {
        statusText.textContent = "❌ Zeitraum bereits belegt.";
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

      const terminData = {
        hallenId: hallenId,
        mieterId: mieterId,
        anlass: anlass,
        anfang: anfang,
        ende: ende,
        confirmed: false,
      };

      const post = await fetch("http://localhost:8080/api/termine", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(terminData),
      });

      if (post.ok) {
        statusText.textContent = "✅ Einzeltermin erfolgreich erstellt!";
        form.reset();
        calendar?.refetchEvents();
      } else {
        statusText.textContent = "❌ Fehler beim Speichern.";
      }
    } else if (typ === "serie") {
      const anfangDatum = form.querySelector("input[name='serieAnfang']").value;
      const endeDatum = form.querySelector("input[name='serieEnde']").value;
      const anfangUhr = form.querySelector("input[name='anfangSerie']").value;
      const endeUhr = form.querySelector("input[name='endeSerie']").value;
      const wochentag = form.querySelector("select[name='wochentag']").value;
      const anlass = form.querySelector("input[name='anlassSerie']").value;
      const username = form.querySelector("input[name='mieterId']").value.trim();

    
      if (!anfangDatum || !endeDatum || !anfangUhr || !endeUhr || !wochentag || !anlass || !username) {
        statusText.textContent = "❌ Bitte alle Felder ausfüllen Serie bro.";
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

      const serienTerminData = {
        hallenId: parseInt(hallenId),
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
  });
});
