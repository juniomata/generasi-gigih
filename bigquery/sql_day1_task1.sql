/*QUESTION:
Find out how many trips for each route
*/


SELECT start_station_name, end_station_name, COUNT(*) AS total_trips
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` 
WHERE subscriber_type = 'Customer'
GROUP BY 1,2
ORDER BY total_trips DESC;