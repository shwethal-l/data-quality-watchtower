<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Data Quality Watchtower</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    h2 { margin-bottom: 12px; }
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ddd; padding: 8px; }
    th { background: #f4f4f4; text-align: left; }
    .severity-medium { color: #d97706; font-weight: bold; }
    .severity-low { color: #16a34a; }
    .severity-high { color: #dc2626; font-weight: bold; }
    .filter { margin-bottom: 12px; }
  </style>
</head>
<body>

  <h2>Data Quality Watchtower</h2>

  <div class="filter">
    <label>
      Severity:
      <select id="severityFilter">
        <option value="">All</option>
        <option value="high">High</option>
        <option value="medium">Medium</option>
        <option value="low">Low</option>
      </select>
    </label>
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
    <tbody id="rows"></tbody>
  </table>

  <script>
    const SUPABASE_URL = "PASTE_SUPABASE_URL_HERE";
    const SUPABASE_KEY = "PASTE_SUPABASE_ANON_KEY_HERE";

    async function loadAnomalies() {
      const severity = document.getElementById("severityFilter").value;
      let url = ${SUPABASE_URL}/rest/v1/quality_anomalies?select=severity,summary,detected_at,recommended_action&order=detected_at.desc;

      if (severity) {
        url += &severity=eq.${severity};
      }

      const res = await fetch(url, {
        headers: {
          apikey: SUPABASE_KEY,
          Authorization: Bearer ${SUPABASE_KEY},
        },
      });

      const data = await res.json();
      const tbody = document.getElementById("rows");
      tbody.innerHTML = "";

      data.forEach(row => {
        const tr = document.createElement("tr");
        tr.innerHTML = `
          <td class="severity-${row.severity}">${row.severity}</td>
          <td>${row.summary}</td>
          <td>${new Date(row.detected_at).toLocaleString()}</td>
          <td>${row.recommended_action}</td>
        `;
        tbody.appendChild(tr);
      });
    }

    document.getElementById("severityFilter").addEventListener("change", loadAnomalies);

    loadAnomalies();
  </script>

</body>
</html>
