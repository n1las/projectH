document.addEventListener("DOMContentLoaded", function() {
  const calendarEl = document.getElementById("calendar");
  const hallenId = localStorage.getItem("selectedSubsiteId");

  async function fetchResourcesFromEvents(events) {
    const uniqueFeldIds = [...new Set(events.map(e => e.feldId))];
    const resources = [];

    for (const feldId of uniqueFeldIds) {
      try {
        const res = await fetch(`http://localhost:8080/api/feld/${feldId}`);
        const feldData = await res.json();
        resources.push({
          id: feldId,
          title: feldData.name // Name aus dem Feld-Objekt
        });
      } catch (err) {
        console.error("Fehler beim Laden des Felds:", feldId, err);
        resources.push({ id: feldId, title: feldId }); // Fallback
      }
    }
    return resources;
  }

  async function loadEventsAndResources(fetchInfo, successCallback, failureCallback) {
    try {
      const res = await fetch(`http://localhost:8080/api/termine/getByHalleId/${hallenId}`);
      const data = await res.json();

      const resources = await fetchResourcesFromEvents(data);

      const events = data.map(e => {
        const resource = resources.find(r => r.id === e.feldId);
        return {
          title: e.anlass,
          start: e.anfang,
          end: e.ende,
          resourceId: resource ? resource.id : null,
          backgroundColor: e.confirmed === "confirmed" ? "green" :
                           e.confirmed === "unconfirmed" ? "gold" : "red",
          borderColor: "gray",
          textColor: e.confirmed === "unconfirmed" ? "black" : "white"
        };
      });

      // Ressourcen dynamisch setzen
      calendar.setOption("resources", resources);
      successCallback(events);

    } catch (err) {
      failureCallback(err);
    }
  }

  if (calendarEl) {
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: "resourceTimeGridDay",
      locale: "de",
      headerToolbar: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,resourceTimeGridDay"
      },
      resources: [], // wird dynamisch gesetzt
      events: loadEventsAndResources
    });

    calendar.render();
  }
});
