-- CTE
-- Select the data only in June 2017
WITH time_range1 AS (
    SELECT trip_id, start_date, end_date
    FROM   `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` 
    WHERE  start_date >= '2017-06-01 00:00:00 UTC'
    AND    start_date <=  '2017-06-30 23:59:59 UTC'
)
-- Select the data 
, time_range2 AS (
    SELECT trip_id, start_date, end_date
    FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` 
    WHERE end_date >= '2017-06-01 00:00:00 UTC' 
    AND start_date <= '2017-06-30 23:59:59 UTC'
)
---------------------------------------------------------------------------
 
-- Query the overlap data
SELECT
    DISTINCT (time_range1.trip_id),
    time_range1.start_date,
    time_range1.end_date,
    COUNT(*) AS number_overlaps
FROM time_range1
INNER JOIN time_range2 
    ON time_range1.start_date <= time_range2.end_date
    AND time_range1.end_date >= time_range2.start_date
GROUP BY 1,2,3
ORDER BY number_overlaps DESC
LIMIT 1;


