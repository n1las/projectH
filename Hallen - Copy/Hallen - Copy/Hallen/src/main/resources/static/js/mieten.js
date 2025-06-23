document.addEventListener("DOMContentLoaded", function () {
const form = document.querySelector("form");
const statusText = document.getElementById("mieten-status");
const calendarEl = document.getElementById("calendar");
const hallenId = localStorage.getItem("selectedSubsiteId");

if (!hallenId) {
    console.error("No hallenId in localStorage");
    if (statusText) statusText.textContent = "Kein Hallen-ID gefunden! ❌";
    return;
}

// 🔁 Kalender initialisieren
let calendar;
if (calendarEl) {
    calendar = new FullCalendar.Calendar(calendarEl, {
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
                    if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);
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

// 📝 Formular absenden
form.addEventListener("submit", async function (e) {
    e.preventDefault();

    const usernameInput = form.querySelector('input[name="username"]');
    const username = usernameInput ? usernameInput.value.trim() : "";

    if (!username || !hallenId) {
        statusText.textContent = "Bitte gib einen gültigen Benutzernamen ein. ❌";
        return;
    }


    const anlass = form.querySelector('input[placeholder="Anlass"]').value;
    const anfang = document.getElementById("anfang").value;
    const ende = document.getElementById("ende").value;

    const checkUrl = `http://localhost:8080/api/termine/check?hallenId=${hallenId}&anfang=${encodeURIComponent(anfang)}&ende=${encodeURIComponent(ende)}`;
    try {
        const checkResponse = await fetch(checkUrl);
        const isAvailable = await checkResponse.json();

        if (!isAvailable) {
            statusText.textContent = "Dieser Zeitraum ist bereits belegt.";
            return;
        }

        const userResponse = await fetch(`http://localhost:8080/api/Mieter/byUsername/${username}`);
        if (!userResponse.ok) throw new Error("Fehler beim Laden des Benutzers.");
        const userData = await userResponse.json();
        console.log("User-Daten aus Backend:", userData);
        const mieterId = userData.id;

        const terminData = {
            hallenId: hallenId,
            mieterId: mieterId,
            anlass: anlass,
            anfang: anfang,
            ende: ende,
            confirmed: false
        };

        const postResponse = await fetch("http://localhost:8080/api/termine", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(terminData)
        });

        if (!postResponse.ok) throw new Error("Fehler beim Erstellen des Termins.");

        statusText.textContent = "✅ Termin erfolgreich erstellt!";
        form.reset();

        // 🔄 Kalender aktualisieren
        if (calendar) {
            calendar.refetchEvents();
        }

    } catch (err) {
        console.error("Fehler:", err);
        statusText.textContent = "Fehler: " + err.message;
    }
});
});
