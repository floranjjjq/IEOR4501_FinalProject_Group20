
WITH snow_days AS (
    SELECT
        DATE(date) AS snow_date,
        SUM(daily_snow_depth) AS total_snowfall
    FROM
        daily_weather
    WHERE
        date BETWEEN '2020-01-01 00:00:00' AND '2024-08-31 23:59:59'
        AND daily_snow_depth > 0
    GROUP BY
        DATE(date)
),
uber_rides AS (
    SELECT
        DATE(pickup_time) AS ride_date,
        COUNT(*) AS total_uber_rides
    FROM
        uber_trips
    WHERE
        pickup_time BETWEEN '2020-01-01 00:00:00' AND '2024-08-31 23:59:59'
    GROUP BY
        DATE(pickup_time)
),
taxi_rides AS (
    SELECT
        DATE(pickup_time) AS ride_date,
        COUNT(*) AS total_taxi_rides
    FROM
        taxi_trips
    WHERE
        pickup_time BETWEEN '2020-01-01 00:00:00' AND '2024-08-31 23:59:59'
    GROUP BY
        DATE(pickup_time)
),
total_rides AS (
    SELECT
        COALESCE(u.ride_date, t.ride_date) AS ride_date,
        COALESCE(u.total_uber_rides, 0) + COALESCE(t.total_taxi_rides, 0) AS total_rides
    FROM
        uber_rides u
    FULL OUTER JOIN
        taxi_rides t
    ON
        u.ride_date = t.ride_date
)
SELECT
    s.snow_date,
    s.total_snowfall,
    COALESCE(r.total_rides, 0) AS total_rides
FROM
    snow_days s
LEFT JOIN
    total_rides r
ON
    s.snow_date = r.ride_date
ORDER BY
    s.total_snowfall DESC
LIMIT 10;
