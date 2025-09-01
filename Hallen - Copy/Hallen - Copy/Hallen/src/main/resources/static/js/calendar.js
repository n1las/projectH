document.addEventListener('DOMContentLoaded', async function () {
    const calendarEl = document.getElementById('calendar');
    const hallenId = localStorage.getItem("selectedSubsiteId");

    // Farb-Mapping nach Status
    function getEventColor(status) {
        switch (status) {
            case 'confirmed': return 'green';
            case 'unconfirmed': return 'gold';
            case 'expired': return 'red';
            case 'block': return 'gray';
            default: return 'blue';
        }
    }

    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        events: async function (fetchInfo, successCallback, failureCallback) {
            try {
                const response = await fetch(`http://localhost:8080/api/termine/MergedTermine/ForCalendar/${hallenId}`);
                if (!response.ok) throw new Error('Fehler beim Laden der Termine');

                const termine = await response.json();

                const events = termine.map(t => ({
                    id: t.id,
                    // Beschreibung direkt an den Titel hängen
                    title: t.anlass + (t.anzahlFelder ? " - " + t.anzahlFelder : ""),
                    start: t.anfang,
                    end: t.ende,
                    color: getEventColor(t.confirmed)
                }));

                successCallback(events);
            } catch (error) {
                console.error(error);
                failureCallback(error);
            }
        },

        // Überschneidende Termine nebeneinander darstellen
        slotEventOverlap: false,
        eventOverlap: true
    });

    calendar.render();
});
