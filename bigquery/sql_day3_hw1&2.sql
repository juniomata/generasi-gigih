/*PROBLEM 1:
Find out the information on stations which
1. Has more than 1000 trips &
2. Has average trip time less than the average trip time of all trips in SF &
3. Does not belong to SF region
Note: take start stations as reference
Submit code: create view with name "sql_day3_hw1"*/
 
-- CTE
WITH 
    sf AS (
        SELECT i.station_id, i.name
        FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` i
        LEFT JOIN `bigquery-public-data.san_francisco_bikeshare.bikeshare_regions` r
        USING(region_id)
        WHERE r.name = "San Francisco"
    ),
 
    avg_time_sf AS (
        SELECT AVG(t.duration_sec) AS avg_time
        FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` AS t
        LEFT JOIN sf  
        ON t.start_station_id = sf.station_id
    ),
 
    selected_trips AS (
        SELECT  
            start_station_id,
            start_station_name, 
            COUNT(trip_id) AS cnt_trip, 
            AVG(duration_sec) AS avg_time
        FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
        GROUP BY start_station_id, start_station_name
        HAVING 
            cnt_trip > 1000 AND 
            avg_time < (SELECT avg_time FROM avg_time_sf)
    )
 
 
-- MAIN QUERY
SELECT 
    DISTINCT (st.start_station_id), 
    st.start_station_name,
    st.cnt_trip,
    st.avg_time 
FROM selected_trips AS st
INNER JOIN 
        -- stations not in SF region
        (SELECT station_id, name
        FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info`
        WHERE name NOT IN (SELECT name FROM sf)) AS not_sf
ON st.start_station_id = not_sf.station_id
ORDER BY st.start_station_id;
/*PROBLEM 2:
 
We want to find out the average time duration between 2 trips for each region
Note: take start stations and trip start date as reference
Hint:
1. First find out the time gap/duration in days between one trip and the nex trip
    Use "TIMESTAMP_DIFF" to calculate the difference in days
2. Next get the average of these time gaps for each region
Submit code: create view with name "sql_day3_hw2"*/
 
-- CTE
WITH 
    trip_info AS (
        SELECT 
            t.trip_id,
            t.start_date,
            t.start_station_id,
            t.start_station_name,
            i.region_id
        FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` AS t  
        LEFT JOIN `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` AS i
        ON t.start_station_id = i.station_id 
    ),
 
    gap AS (
        SELECT 
            start_station_name,
            start_date,
            region_id, 
            LEAD(start_date) OVER (PARTITION BY start_station_name ORDER BY start_date),
            TIMESTAMP_DIFF(
                    LEAD(start_date) 
                    OVER (PARTITION BY start_station_name 
                    ORDER BY start_date), start_date, DAY) AS time_diff
        FROM trip_info
    )
 
 
-- MAIN QUERY
SELECT 
    DISTINCT name,
    AVG(time_diff) OVER (PARTITION BY gap.region_id) AS avg_time_gap
FROM gap
LEFT JOIN `bigquery-public-data.san_francisco_bikeshare.bikeshare_regions` AS r
USING(region_id)
ORDER BY avg_time_gap;
 