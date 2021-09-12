SELECT
  s.station_id,
  s.name AS station_name,
  r.region_id,
  r.name AS region_name,
  COUNT(DISTINCT trip_id) cnt_trip_station,
  COUNT(DISTINCT trip_id)/cnt_trip_region pct_trip_station
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` t
LEFT JOIN
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` s
ON
  t.start_station_id = s.station_id
LEFT JOIN
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_regions` r
ON
  s.region_id = r.region_id
JOIN
  `gg-data-bangsa.gg000000_hasbi.sql_day2_task1_1` rs
ON
  r.region_id = rs.region_id
GROUP BY
  1,
  2,
  3,
  4,
  cnt_trip_region
ORDER BY
  3,
  1