
WITH filtered_trips AS (
    SELECT 
        trip_distance
    FROM 
        uber_trips
    WHERE 
        DATE(pickup_time) BETWEEN '2024-01-01' AND '2024-01-31'
),
percentile_calculation AS (
    SELECT 
        trip_distance,
        ROW_NUMBER() OVER (ORDER BY trip_distance) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM 
        filtered_trips
)
SELECT 
    trip_distance
FROM 
    percentile_calculation
WHERE 
    row_num = CAST(total_rows * 0.95 AS INTEGER);
