document.addEventListener('DOMContentLoaded', () => {
  const calendarEl = document.getElementById('calendar');
  const hallenId = localStorage.getItem("selectedSubsiteId");
  const status = document.getElementById("mieten-status");

  if (!hallenId) {
    console.error("No hallenId in localStorage");
    if (status) status.textContent = "Kein Hallen-ID gefunden! ❌";
    return;
  }

  // --- FullCalendar Setup ---
  if (calendarEl) {
    const calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      locale: 'de',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      events: function(fetchInfo, successCallback, failureCallback) {
        fetch(`http://localhost:8080/api/termine`)
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

  // --- Delete Termin Form Logic ---
  const deleteForm = document.getElementById("delete-form");
  if (deleteForm) {
    deleteForm.addEventListener("submit", async function (e) {
      e.preventDefault(); // prevent page reload

      const startDateTimeInput = document.getElementById("start-datetime").value;

      if (!startDateTimeInput) {
        status.textContent = "Bitte Datum & Uhrzeit auswählen! ❌";
        return;
      }

      const url = `http://localhost:8080/api/termine/delete?hallenId=${hallenId}&startDateTime=${encodeURIComponent(startDateTimeInput)}`;

      try {
        const response = await fetch(url, {
          method: "DELETE"
        });

        if (response.ok) {
          status.textContent = "Termin erfolgreich gelöscht! 🧹";
          // Optionally refresh calendar
          if (calendarEl) {
            calendar.getEventSources().forEach(source => source.remove());
            calendar.refetchEvents();
          }
        } else {
          const errorText = await response.text();
          status.textContent = `Fehler: ${errorText} ❌`;
        }
      } catch (error) {
        console.error("Error deleting termin:", error);
        status.textContent = "Ein Fehler ist aufgetreten. 😵";
      }
    });
  }
});
