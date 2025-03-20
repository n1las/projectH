async function loadImage() {
    try {
        const response = await fetch("http://localhost:8080/api/Hallen"); // Calls your API
        const hallen = await response.json();
        
        if (hallen.length > 0 && hallen[0].imageUrl) {
            document.getElementById("image").src = hallen[0].imageUrl; // Show first hall's image
        } else {
            document.getElementById("image").alt = "No image found";
        }
    } catch (error) {
        console.error("Error fetching image:", error);
    }
}

loadImage();