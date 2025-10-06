document.addEventListener('DOMContentLoaded', () => {
  // --- Helper function ---
  function getIdFromUrl() {
    const path = window.location.pathname;
    const segments = path.split("/");
    return segments.length > 2 ? segments[2] : null;
  }

  // --- Save selectedSubsiteId in localStorage ---
  const hallenId = getIdFromUrl();
  if (hallenId) {
    localStorage.setItem("selectedSubsiteId", hallenId);
    console.log(`✅ Hallen-ID '${hallenId}' wurde in localStorage gespeichert.`);
  } else {
    console.warn("⚠️ Keine Hallen-ID in der URL gefunden.");
  }

  // --- FullCalendar Setup ---
  const calendarEl = document.getElementById('calendar');
  if (calendarEl && hallenId) {
    const calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      locale: 'de',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      events: function(fetchInfo, successCallback, failureCallback) {
        fetch(`/api/termine`)
          .then(response => {
            if (!response.ok) {
              throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
          })
          .then(data => {
            const filteredEvents = data
              .filter(event => event.hallenId == hallenId)
              .map(event => ({
                id: event.id,
                title: event.anlass || "Ohne Titel",
                start: event.anfang,
                end: event.ende
              }));

            successCallback(filteredEvents);
          })
          .catch(error => {
            console.error("Error fetching events:", error);
            failureCallback(error);
          });
      }
    });
    calendar.render();
  }

  // --- Fetch and display Hallen data ---
  if (hallenId) {
    fetch(`/api/Hallen/${hallenId}`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        const imageElement = document.getElementById("dynamicImage");
        if (imageElement) {
          imageElement.src = data.imageUrl || "";
          imageElement.alt = data.name || "Hallenbild";
        }
        document.getElementById("name").textContent = data.name || "Name not available";
        document.getElementById("hallenAdresse").textContent = (data.strasse || "") + " " + (data.strasseNr || "");
        document.getElementById("ort").textContent = data.ort || "Ort not available";
        document.getElementById("plz").textContent = data.plz || "PLZ not available";
        document.getElementById("sfg").textContent = data.spielfeldgroesse || "Größe not available";
      })
      .catch(error => console.error("Error fetching data:", error));
  }
});
