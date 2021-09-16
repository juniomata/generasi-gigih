SELECT
  a.trip_id,
  a.timestamp as start_date,
  a.station_name as start_station_name,
  b.timestamp as end_date,
  b.station_name as end_station_name,
FROM `gg-data-bangsa.gg000000_hasbi.sql_day2_task2` as a
LEFT JOIN `gg-data-bangsa.gg000000_hasbi.sql_day2_task2` as b
  ON a.trip_id = b.trip_id
WHERE a.trip_status = 'Started'
  AND b.trip_status = 'Ended'