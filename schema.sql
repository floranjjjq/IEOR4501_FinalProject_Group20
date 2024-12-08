
CREATE TABLE IF NOT EXISTS hourly_weather 
(
    hourly_time DATETIME PRIMARY KEY,
    hourly_temperature FLOAT,
    hourly_present_weather_type STRING,
    hourly_sky_conditions STRING,
    hourly_visibility FLOAT,
    hourly_precipitation FLOAT
)

CREATE TABLE IF NOT EXISTS daliy_weather 
(
    date DATETIME PRIMARY KEY,
    sunrise TIME,
    sunset TIME,
    daily_average_temperature FLOAT,
    daily_average_wind_speed FLOAT,
    daily_maximum_temperature FLOAT,
    daily_minimum_temperature FLOAT,
    daily_weather STRING,
    daily_snow_depth FLOAT
)

CREATE TABLE IF NOT EXISTS taxi_trips 
(
    id INTEGER PRIMARY KEY,
    pickup_time DATETIME,
    dropoff_time DATETIME,
    passenger_count INTEGER,
    trip_distance FLOAT,
    fare_amount FLOAT,
    miscellaneous_extra_charges FLOAT,
    mta_tax FLOAT,
    tip_amount FLOAT,
    tolls_amount FLOAT,
    improvement_surcharge FLOAT,
    congestion_surcharge FLOAT,
    airport_fee FLOAT,
    pickup_latitude FLOAT,
    pickup_longitude FLOAT,
    dropoff_latitude FLOAT,
    dropoff_longitude FLOAT
)

CREATE TABLE IF NOT EXISTS uber_trips 
(
    id INTEGER PRIMARY KEY,
    pickup_time DATETIME,
    dropoff_time DATETIME,
    pickup_location_id INTEGER,
    dropoff_location_id INTEGER,
    trip_distance FLOAT,
    base_passenger_fare FLOAT,
    tolls FLOAT,
    sales_tax FLOAT,
    congestion_surcharge FLOAT,
    airport_fee FLOAT,
    tips FLOAT,
    driver_pay FLOAT,
    pickup_latitude FLOAT,
    pickup_longitude FLOAT,
    dropoff_latitude FLOAT,
    dropoff_longitude FLOAT
)
