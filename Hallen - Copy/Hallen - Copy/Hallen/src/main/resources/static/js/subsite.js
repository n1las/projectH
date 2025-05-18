// -----------------------------
// FullCalendar Setup (Wrapped)
// -----------------------------
(function () {
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');

        if (!calendarEl) return; // Skip if calendar element doesn't exist

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'de',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: [
                {
                    title: 'Renovieren',
                    start: '2025-06-01T14:00:00',
                    end: '2025-06-01T22:00:00'
                },
                {
                    title: 'Einrichtung',
                    start: '2025-06-30T13:00:00',
                    end: '2025-06-30T15:00:00'
                }
            ]
        });

        calendar.render();
    });
})();

// ------------------------------------------
// Data Fetching and DOM Injection (Wrapped)
// ------------------------------------------
(function () {
    // Extract ID from URL
    function getIdFromUrl() {
        const path = window.location.pathname;
        const segments = path.split("/");
        return segments[2];
    }

    // Fetch and display data
    function fetchImage() {
        const hallenId = getIdFromUrl();
        if (!hallenId) {
            console.error("No ID found in URL");
            return;
        }

        fetch(`http://localhost:8080/api/Hallen/${hallenId}`)
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

    // Call on page load
    document.addEventListener("DOMContentLoaded", fetchImage);
})();
