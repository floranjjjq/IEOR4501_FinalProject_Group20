
SELECT 
    STRFTIME('%H', pickup_time) AS hour_of_day,
    COUNT(*) AS ride_count
FROM taxi_trips
WHERE pickup_time BETWEEN '2020-01-01' AND '2024-08-31'
GROUP BY hour_of_day
ORDER BY ride_count DESC;
