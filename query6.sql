
WITH RECURSIVE dates(x) AS (
    SELECT '2023-09-25 00:00:00' -- Start date and time
    UNION ALL
    SELECT datetime(x, '+1 hour')
    FROM dates
    WHERE x < '2023-10-03 23:00:00' -- End date and time
),
uber_hourly_rides AS (
    SELECT 
        strftime('%Y-%m-%d %H:00:00', pickup_time) AS hourly_time,
        COUNT(*) AS uber_rides
    FROM 
        uber_trips
    WHERE 
        pickup_time >= '2023-09-25 00:00:00' AND pickup_time <= '2023-10-03 23:59:59'
    GROUP BY 
        hourly_time
),
taxi_hourly_rides AS (
    SELECT 
        strftime('%Y-%m-%d %H:00:00', pickup_time) AS hourly_time,
        COUNT(*) AS taxi_rides
    FROM 
        taxi_trips
    WHERE 
        pickup_time >= '2023-09-25 00:00:00' AND pickup_time <= '2023-10-03 23:59:59'
    GROUP BY 
        hourly_time
),
hourly_rides AS (
    SELECT 
        COALESCE(u.hourly_time, t.hourly_time) AS hourly_time,
        COALESCE(u.uber_rides, 0) + COALESCE(t.taxi_rides, 0) AS num_rides
    FROM 
        uber_hourly_rides u
    FULL OUTER JOIN 
        taxi_hourly_rides t
    ON 
        u.hourly_time = t.hourly_time
),
hourly_weather_data AS (
    SELECT 
        strftime('%Y-%m-%d %H:00:00', hourly_time) AS hourly_time,
        SUM(hourly_precipitation) AS total_precipitation,
        AVG(hourly_wind_speed) AS avg_wind_speed
    FROM 
        hourly_weather
    WHERE 
        hourly_time BETWEEN '2023-09-25' AND '2023-10-03'
    GROUP BY 
        hourly_time
),
combined_data AS (
    SELECT 
        d.x AS hourly_time,
        COALESCE(r.num_rides, 0) AS num_rides,
        COALESCE(w.total_precipitation, 0) AS total_precipitation,
        COALESCE(w.avg_wind_speed, 0) AS avg_wind_speed
    FROM 
        dates d
    LEFT JOIN 
        hourly_rides r
    ON 
        d.x = r.hourly_time
    LEFT JOIN 
        hourly_weather_data w
    ON 
        d.x = w.hourly_time
)
SELECT 
    hourly_time,
    num_rides,
    total_precipitation,
    avg_wind_speed
FROM 
    combined_data
ORDER BY 
    hourly_time ASC;

