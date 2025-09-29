// calendar.js

let calendar; // global calendar instance

window.initCalendar = function () {
    const calendarEl = document.getElementById('calendar');
    const hallenId = localStorage.getItem("selectedSubsiteId");

    function getEventColor(status) {
        switch (status) {
            case 'confirmed': return 'green';
            case 'unconfirmed': return 'gold';
            case 'expired': return 'red';
            case 'block': return 'purple';
            case 'cancelled': return 'gray';
            default: return 'blue';
        }
    }

calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    locale: 'de', 
    eventTimeFormat: {
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    },
        events: async function (fetchInfo, successCallback, failureCallback) {
            try {
                const response = await fetch(`http://localhost:8080/api/termine/MergedTermine/ForCalendar/${hallenId}`);
                if (!response.ok) throw new Error('Fehler beim Laden der Termine');

                const termine = await response.json();

                const events = termine.map(t => ({
                    id: t.id,
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
        slotEventOverlap: false,
        eventOverlap: true
    });

    calendar.render();
};

// Refresh calendar events without duplication
window.refreshCalendar = function () {
    if (calendar) {
        // Refetch events from the original events function
        calendar.refetchEvents();
    } else {
        window.initCalendar();
    }
};

// Initialize calendar on page load
document.addEventListener('DOMContentLoaded', () => {
    window.initCalendar();
});
