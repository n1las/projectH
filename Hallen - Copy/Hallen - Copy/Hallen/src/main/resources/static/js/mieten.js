document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const statusText = document.getElementById("mieten-status");

    form.addEventListener("submit", async function (e) {
        e.preventDefault();

        const username = localStorage.getItem("username");
        const selectedSubsiteId = localStorage.getItem("selectedSubsiteId");

        if (!username || !selectedSubsiteId) {
            statusText.textContent = "Username oder Halle-ID fehlt im localStorage.";
            return;
        }

        const anlass = form.querySelector('input[placeholder="Anlass"]').value;
        const anfang = document.getElementById("anfang").value;
        const ende = document.getElementById("ende").value;

        const checkUrl = `http://localhost:8080/api/termine/check?hallenId=${selectedSubsiteId}&anfang=${encodeURIComponent(anfang)}&ende=${encodeURIComponent(ende)}`;
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
            const mieterId = userData.id;

            const terminData = {
                hallenId: selectedSubsiteId,
                mieter_ID: mieterId,
                anlass: anlass,
                anfang: anfang,
                ende: ende
            };

            const postResponse = await fetch("http://localhost:8080/api/termine", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(terminData)
            });

            if (!postResponse.ok) throw new Error("Fehler beim Erstellen des Termins.");

            statusText.textContent = "Termin erfolgreich erstellt!";
            form.reset();

        } catch (err) {
            console.error("Fehler:", err);
            statusText.textContent = "Fehler: " + err.message;
        }
    });
});
