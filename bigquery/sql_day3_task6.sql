SELECT
   trip_id,
   start_date,
   start_station_name,
   end_station_name,
   bike_number,
   LAG(end_station_name) OVER(PARTITION BY bike_number ORDER BY start_date) prev_destination,
   LEAD(start_station_name) OVER(PARTITION BY bike_number ORDER BY start_date) next_origin,
  
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
order by bike_number , start_date