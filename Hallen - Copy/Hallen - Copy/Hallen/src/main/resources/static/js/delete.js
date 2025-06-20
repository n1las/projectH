document.addEventListener('DOMContentLoaded', () => {
  // --- FullCalendar Setup ---
  const calendarEl = document.getElementById('calendar');
  if (calendarEl) {
    const hallenId = localStorage.getItem("selectedSubsiteId");
    if (!hallenId) {
      console.error("No hallenId in URL");
    } else {
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
  }
});