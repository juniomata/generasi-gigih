SELECT
   trip_id,
   start_date,
   duration_sec,
   bike_number,
   AVG(duration_sec) OVER(PARTITION BY bike_number ORDER BY start_date RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) moving_average

FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
order by bike_number , start_date