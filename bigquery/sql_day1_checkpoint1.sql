/*QUESTION:
Find out the number of trips started for each station

SELECT
  start_station_name,
  COUNT(*) AS total_trips
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
GROUP BY
  start_station_name;