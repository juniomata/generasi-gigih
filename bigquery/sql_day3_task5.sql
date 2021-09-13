SELECT
  trip_id,
  start_station_name,
  end_station_name,
  zip_code,
  COUNT(DISTINCT trip_id) OVER (PARTITION BY zip_code) cnt_trips_zip
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`