
WITH ride_counts AS (
    SELECT
        DATE(pickup_time) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_distance) AS avg_distance
    FROM
        uber_trips
    WHERE
        pickup_time BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY
        DATE(pickup_time)
    UNION ALL
    SELECT
        DATE(pickup_time) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_distance) AS avg_distance
    FROM
        taxi_trips
    WHERE
        pickup_time BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY
        DATE(pickup_time)
),
combined_counts AS (
    SELECT
        ride_date,
        SUM(total_rides) AS total_rides,
        AVG(avg_distance) AS avg_distance
    FROM
        ride_counts
    GROUP BY
        ride_date
),
top_10_days AS (
    SELECT
        ride_date,
        total_rides,
        avg_distance
    FROM
        combined_counts
    ORDER BY
        total_rides DESC
    LIMIT 10
)
SELECT
    t.ride_date,
    t.total_rides,
    t.avg_distance,
    AVG(w.hourly_precipitation) AS avg_precipitation,
    AVG(w.hourly_wind_speed) AS avg_wind_speed
FROM
    top_10_days t
JOIN
    hourly_weather w
ON
    DATE(w.hourly_time) = t.ride_date
GROUP BY
    t.ride_date, t.total_rides, t.avg_distance
ORDER BY
    t.total_rides DESC;
