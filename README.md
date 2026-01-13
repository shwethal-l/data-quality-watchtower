<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Data Quality Watchtower</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 24px;
    }
    h2 {
      margin-bottom: 16px;
    }
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f4f4f4;
    }
    .severity-high {
      color: #dc2626;
      font-weight: bold;
    }
    .severity-medium {
      color: #d97706;
      font-weight: bold;
    }
    .severity-low {
      color: #16a34a;
    }
    .filter {
      margin-bottom: 16px;
    }
  </style>
</head>

<body>

  <h2>Data Quality Watchtower</h2>

  <div class="filter">
    <label for="severityFilter">Severity:</label>
    <select id="severityFilter">
      <option value="">All</option>
      <option value="high">High</option>
      <option value="medium">Medium</option>
      <option value="low">Low</option>
    </select>
  </div>

  <table>
    <thead>
      <tr>
        <th>Severity</th>
        <th>Summary</th>
        <th>Detected At</th>
        <th>Recommended Action</th>
      </tr>
    </thead>
    <tbody id="rows">
      <!-- Data will be injected here -->
    </tbody>
  </table>

  <script>
    // 🔴 REPLACE THESE TWO VALUES ONLY
    var SUPABASE_URL = "https://rmlgkaxrpiodrywquveq.supabase.co";
    var SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJtbGdrYXhycGlvZHJ5d3F1dmVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgxMDYxNTUsImV4cCI6MjA4MzY4MjE1NX0.P6wEHxPgF5L7wvjY1hJap3wzGHK8VJZmi6qIXFL80dk";

    function loadAnomalies() {
      var severity = document.getElementById("severityFilter").value;
      var url = SUPABASE_URL +
        "/rest/v1/quality_anomalies?select=severity,summary,detected_at,recommended_action&order=detected_at.desc";

      if (severity) {
        url = url + "&severity=eq." + severity;
      }

      fetch(url, {
        headers: {
          "apikey": SUPABASE_KEY,
          "Authorization": "Bearer " + SUPABASE_KEY
        }
      })
      .then(function(response) {
        return response.json();
      })
      .then(function(data) {
        var tbody = document.getElementById("rows");
        tbody.innerHTML = "";

        for (var i = 0; i < data.length; i++) {
          var row = data[i];
          var tr = document.createElement("tr");

          tr.innerHTML =
            "<td class='severity-" + row.severity + "'>" + row.severity + "</td>" +
            "<td>" + row.summary + "</td>" +
            "<td>" + new Date(row.detected_at).toLocaleString() + "</td>" +
            "<td>" + row.recommended_action + "</td>";

          tbody.appendChild(tr);
        }
      })
      .catch(function(error) {
        console.error("Error loading anomalies:", error);
      });
    }

    document.getElementById("severityFilter")
      .addEventListener("change", loadAnomalies);

    loadAnomalies();
  </script>

</body>
</html>
