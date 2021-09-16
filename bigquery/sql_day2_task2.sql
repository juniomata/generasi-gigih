SELECT
  trip_id,
  start_date AS timestamp,
  start_station_name AS station_name,
  'Started' AS trip_status
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
UNION ALL
SELECT
  trip_id,
  end_date AS timestamp,
  end_station_name AS station_name,
  'Ended' AS trip_status
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
ORDER BY
  trip_id,
  timestamp