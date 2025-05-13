// Function to extract ID from the URL
function getIdFromUrl() {
    const path = window.location.pathname; // Example: "/subsite/1"
    const segments = path.split("/");      // ["", "subsite", "1"]
    return segments[2];                    // Get the ID
}

// Function to fetch and display data
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
            // Set image
            const imageElement = document.getElementById("dynamicImage");
            imageElement.src = data.imageUrl || "";
            imageElement.alt = data.name || "Hallenbild";

            // Set name
            document.getElementById("name").textContent = data.name || "Name not available";

            // Set street
            document.getElementById("hallenAdresse").textContent = data.strasse + " " + data.strasse_nr|| "Street not available";

             // Set ort
            document.getElementById("ort").textContent = data.ort || "Street not available";

            // Set plz
            document.getElementById("plz").textContent = data.plz || "Street not available";

             document.getElementById("sfg").textContent = data.spielfeldgroesse || "Street not available";
        })
        .catch(error => console.error("Error fetching data:", error));
}

// Call function on page load
fetchImage();
