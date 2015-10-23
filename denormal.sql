\c StyeL

DROP DATABASE denormal_cars;

-- Create a new database named denormal_cars owned by denormal_user
CREATE DATABASE denormal_cars OWNER denormal_user;

\c denormal_user

-- Run the provided scripts/denormal_data.sql script on the denormal_cars database
\i scripts/denormal_data.sql

-- Inspect the table named car_models by running \dS and look at the data using some SELECT statements
-- In denormal.sql Create a query to get a list of all make_title values in the car_models table, without any duplicate rows. (should have 71 results)
-- In denormal.sql Create a query to list all model_title values where the make_code is 'VOLKS', without any duplicate rows (should have 27 results)
-- In denormal.sql Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM' (should have 136 rows)
-- In denormal.sql Create a query to list all fields from all car_models in years between 2010 and 2015 (should have 7884 rows)