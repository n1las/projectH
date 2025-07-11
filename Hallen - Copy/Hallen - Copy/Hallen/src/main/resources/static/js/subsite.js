document.addEventListener('DOMContentLoaded', () => {
  // --- FullCalendar Setup ---
  const calendarEl = document.getElementById('calendar');
  if (calendarEl) {
    const hallenId = getIdFromUrl();
    if (!hallenId) {
      console.error("No hallenId in URL");
    } else {
      const calendar = new FullCalendar.Calendar(calendarEl, {
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
              if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
              }
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
  }

  // --- Fetch and display Hallen data ---
  const hallenId = getIdFromUrl();
  if (!hallenId) {
    console.error("No ID found in URL");
  } else {
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

  // --- Show "mieten-button" if token exists ---
  const token = localStorage.getItem('token');
  if (token) {
    const mietenButton = document.getElementById('mieten-button');
    const deleteButton = document.getElementById('deleteButton');
    const isAdmin = localStorage.getItem("isAdmin");
    console.log(isAdmin);
    if (isAdmin) {
      mietenButton.style.display = 'inline-block';
      deleteButton.style.display ='inline-block';

      deleteButton.addEventListener("click", () => {
        const hallenId = getIdFromUrl();
        if (hallenId) {
          localStorage.setItem("selectedSubsiteId", hallenId);
          console.log(`Subsite ID '${hallenId}' saved to localStorage.`);
        } else {
          console.warn("Subsite ID not found in URL.");
        }
      });

      mietenButton.addEventListener("click", () => {
        const hallenId = getIdFromUrl();
        if (hallenId) {
          localStorage.setItem("selectedSubsiteId", hallenId);
          console.log(`Subsite ID '${hallenId}' saved to localStorage.`);
        } else {
          console.warn("Subsite ID not found in URL.");
        }
      });
    }
  }

  // ✅ --- Login/Logout Button Logic ---
  const loginBtn = document.getElementById('login-button');

  if (token && loginBtn) {
    loginBtn.textContent = 'LOGOUT';
    loginBtn.addEventListener('click', () => {
      localStorage.removeItem('token');
      localStorage.removeItem('username');
      window.location.href = '/home';
    });
  } else if (loginBtn) {
    loginBtn.addEventListener('click', () => {
      window.location.href = '/login';
    });
  }

  // --- Helper function ---
  function getIdFromUrl() {
    const path = window.location.pathname;
    const segments = path.split("/");
    return segments[2]; // Adjust if your URL structure differs
  }
});
