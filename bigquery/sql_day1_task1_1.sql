/*QUESTION:
How many trips started from every region?
*/


SELECT 
  first.region_id,
  first.name AS region_name,
  COUNT(DISTINCT trip_id) AS cnt_trip_region
FROM 
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` AS third
LEFT JOIN 
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` AS second
ON
  third.start_station_id = second.station_id
LEFT JOIN 
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_regions` AS first
ON
  second.region_id = first.region_id
GROUP BY 
  first.region_id,
  first.name