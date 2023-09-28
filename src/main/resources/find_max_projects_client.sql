SELECT
  c.client_name AS NAME,
  COUNT(p.project_id) AS PROJECT_COUNT
FROM client c
LEFT JOIN project p ON c.client_id = p.client_id
GROUP BY c.client_name
HAVING COUNT(p.project_id) = (
  SELECT MAX(project_count)
  FROM (
    SELECT COUNT(project_id) AS project_count
    FROM project
    GROUP BY client_id
  ) AS project_counts
);