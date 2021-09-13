-- We want to find out the stations which not in SF regions
-- Show the station name and ID

SELECT
  name,
  station_id,
  region_id
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info`
WHERE
  region_id NOT IN (
  SELECT
    region_id
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_regions`
  WHERE
    name = "San Francisco" )