  document.addEventListener("DOMContentLoaded", async () => {
    const userId = window.location.pathname.split("/").pop();

    // Daten des Users laden
    try {
      const response = await fetch(`/api/Mieter/${userId}`);
      if (!response.ok) throw new Error("Fehler beim Laden der Benutzerdaten.");

      const user = await response.json();

      // Formular mit Userdaten füllen
      document.getElementById("username").value = user.username || "";
      document.getElementById("password").value = user.passwort || "";
      if(user.admin){
        document.getElementById("role").value = "Admin";
      }
      else{
        document.getElementById("role").value = "Verein";
      }
    } catch (err) {
      alert("Fehler beim Laden: " + err.message);
    }

    // Formular absenden
    document.getElementById("edit-user-form").addEventListener("submit", async (e) => {
      e.preventDefault();
      let isAdmin
      if (document.getElementById("role").value == "Admin"){
         isAdmin = true;
      }
      else{
         isAdmin = false;
      }

      const updatedUser = {
        username: document.getElementById("username").value,
        passwort: document.getElementById("password").value,
        admin: isAdmin
      };

      try {
        const res = await fetch(`/api/Mieter/${userId}`, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(updatedUser)
        });

        if (!res.ok) throw new Error("Update fehlgeschlagen");

        alert("Benutzer erfolgreich aktualisiert!"); // ggf. anpassen
      } catch (err) {
        alert("Fehler beim Speichern: " + err.message);
      }
    });

    // Abbrechen → zurück zur vorherigen Seite
    document.querySelector(".cancel").addEventListener("click", () => {
      window.history.back();
    });
  });