SELECT
  g.incident_name,
  g.min_estimated_time,
  g.max_estimated_time,
  t.trip_id,
  t.start_date,
  t.end_date,
  (g.max_estimated_time - g.min_estimated_time) inc_time_diff,
  (t.end_date - t.start_date) trip_time_diff
FROM
  `gg-data-bangsa.gg000000_hasbi.bikeshare_graffiti_incident` as g
JOIN
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` as t
  ON (
    t.start_date BETWEEN g.min_estimated_time and g.max_estimated_time
    OR t.end_date BETWEEN g.min_estimated_time and g.max_estimated_time
    OR min_estimated_time BETWEEN t.start_date and t.end_date
    OR max_estimated_time BETWEEN t.start_date and t.end_date
    )
  ORDER BY g.incident_name