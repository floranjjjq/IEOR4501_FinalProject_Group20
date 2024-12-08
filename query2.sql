
SELECT 
    strftime('%w', pickup_time) AS day_of_week, 
    COUNT(*) AS ride_count
FROM uber_trips
WHERE pickup_time BETWEEN '2020-01-01' AND '2024-08-31'
GROUP BY day_of_week
ORDER BY ride_count DESC; 
