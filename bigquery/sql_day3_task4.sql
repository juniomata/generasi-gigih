WITH cte AS (
    SELECT zip_code, count(distinct trip_id) cnt_trip
    FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
    GROUP BY 1
)

# MAIN QUERY
SELECT DISTINCT start_station_name, zip_code, cnt_trip
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
LEFT JOIN cte
USING(zip_code)
ORDER BY 2,1