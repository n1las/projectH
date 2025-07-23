  document.addEventListener("DOMContentLoaded", async () => {

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

      const newUser = {
        username: document.getElementById("username").value,
        passwort: document.getElementById("password").value,
        admin: isAdmin
      };

      try {
        const res = await fetch("/api/Mieter", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(newUser)
        });

        if (!res.ok) throw new Error("Benutzer konnte nicht erstellt werden");

        alert("Benutzer erfolgreich erstellt"); // ggf. anpassen
      } catch (err) {
        alert("Fehler beim Speichern: " + err.message);
      }
    });

    // Abbrechen → zurück zur vorherigen Seite
    document.querySelector(".cancel").addEventListener("click", () => {
      window.history.back();
    });
  });