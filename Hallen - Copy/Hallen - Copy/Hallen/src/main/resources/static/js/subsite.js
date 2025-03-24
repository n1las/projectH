        // Function to extract ID from the URL
        function getIdFromUrl() {
            const path = window.location.pathname;  // Example: "/subsite/1"
            const segments = path.split("/"); // Splits into ["", "subsite", "1"]
            return segments[2]; // Get the ID (third element)
        }

        // Function to fetch and display the image
        function fetchImage() {
            const hallenId = getIdFromUrl();
            if (!hallenId) {
                console.error("No ID found in URL");
                return;
            }

            fetch(`http://localhost:8080/api/Hallen/${hallenId}`)
                .then(response => response.json())  // Convert response to JSON
                .then(data => {
                    document.getElementById("dynamicImage").src = data.imageUrl; // Set image src
                })
                .catch(error => console.error("Error fetching data:", error));
        }

        // Call function on page load
        console.log("hahahahah");
        fetchImage();
        