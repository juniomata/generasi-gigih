-- We want to see how each stations contrbutes to the overall trips in every region (station as the starting point of trip)
-- Show the %trip contribtuion of each station on their respective region

WITH cte AS(
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
)

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
  cte rs
ON
  r.region_id = rs.region_id
GROUP BY
  1,2,3,4,cnt_trip_region
ORDER BY
  3,1