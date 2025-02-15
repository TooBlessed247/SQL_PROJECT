-- SQL PROJECT 2 FOR OJOMA BLESSING IYE

-- Select Statement
-- 1. Retrieve all columns from the `stolen_vehicles` table.
select *
from stolenvehicles;

-- 2. Select only the `vehicle_type`, `make_id`, and `color` columns from the `stolen_vehicles` table.
select vehicle_type, make_id, color
from stolenvehicles;

-- From Statement
-- 1. Write a query to display all records from the `make_details` table.
select *
from  make_details;

-- 2. Retrieve all columns from the `locations` table.
select *
from locations;

-- Where Statement
-- Find all stolen vehicles that are of type "Trailer".
select vehicle_id, vehicle_desc
from stolenvehicles
where vehicle_desc like "Trailer";

-- 2. Retrieve all stolen vehicles that were stolen after January 1, 2022.
select vehicle_id, vehicle_type, date_stolen
from stolenvehicles
where date_stolen > "1/1/2022";

-- 3. Find all stolen vehicles that are of color "Silver".
select vehicle_id, model_year, vehicle_desc, date_stolen, color
from stolenvehicles
where color like "Silver";

-- Group By and Order By
-- 1. Count the number of stolen vehicles for each `vehicle_type` and order the results by the count in
-- descending order.
select vehicle_type, count(vehicle_type) stolen_vehicle_type
from stolenvehicles
group by vehicle_type
order by vehicle_type desc;


-- 2. Find the total number of stolen vehicles for each `make_id` and order the results by `make_id`.
select make_id, count(make_id) number_of_stolen_vehicle
from stolenvehicles
group by make_id
order by make_id;


-- Using Having vs. Where Statement
-- 1. Find the `make_id` values that have more than 10 stolen vehicles.
select vehicle_id, make_id
from stolenvehicles
where make_id > 10;

-- 2. Retrieve the `vehicle_type` values that have at least 5 stolen vehicles.
select vehicle_type, count(vehicle_id)
from stolenvehicles
group by vehicle_type
having count(vehicle_id) >= 5;



-- Limit and Aliasing
-- 1. Retrieve the first 10 records from the `stolen_vehicles` table and alias the `vehicle_type` column as
-- "Type".
SELECT *, vehicle_type AS "Type" 
FROM stolenvehicles
LIMIT 10;


-- 2. Find the top 5 most common colors of stolen vehicles and alias the count column as "Total".
SELECT color, COUNT(color)  "Total"
FROM stolenvehicles
GROUP BY color
ORDER BY "Total" DESC
LIMIT 5;


-- Joins in MySQL
-- 1. Join the `stolen_vehicles` table with the `make_details` table to display the `vehicle_type`,
-- `make_name`, and `color` of each stolen vehicle.
select s.vehicle_type, s.color, m.make_name
from stolenvehicles s
inner join make_details m
on
 s.vehicle_id = m.make_id;


-- 2. Join the `stolen_vehicles` table with the `locations` table to display the `vehicle_type`, `region`, and
-- `country` where the vehicle was stolen.
select s.vehicle_type, l.region, l.country
from stolenvehicles s
inner join locations l
on 
s.vehicle_id = l.location_id;


-- Unions in MySQL
-- 1. Write a query to combine the `make_name` from the `make_details` table and the `region` from the
-- `locations` table into a single column.
select make_name
from make_details
union
select region
from locations;

-- PROJECT 2

-- 2. Combine the `vehicle_type` from the `stolen_vehicles` table and the `make_type` from the
-- `make_details` table into a single column.
select vehicle_type
from stolenvehicles
union
select make_type
from make_details; 

-- Case Statements
-- 1. Create a new column called "Vehicle_Category" that categorizes vehicles as "Luxury" if the
-- `make_type` is "Luxury" and "Standard" otherwise.
SELECT *,
       CASE 
           WHEN vehicle_type = 'Luxury' THEN 'Luxury'
           ELSE 'Standard'
       END AS Vehicle_Category
FROM stolenvehicles;
 
 
 
-- 2. Use a CASE statement to categorize stolen vehicles as "Old" if the `model_year` is before 2010, "Mid"
-- if between 2010 and 2019, and "New" if 2020 or later.
SELECT *,
       CASE 
           WHEN model_year < 2010 THEN 'Old'
           WHEN model_year BETWEEN 2010 AND 2019 THEN 'Mid'
           WHEN model_year >= 2020 THEN 'New'
       END AS Vehicle_Age_Category
FROM stolenvehicles;


-- Aggregate Functions
-- 1. Calculate the total number of stolen vehicles.
select count(vehicle_id) Total_Vehicles_Stolen
from stolenvehicles;


-- 2. Find the average population of regions where vehicles were stolen.
select region, avg(population)
from locations
group by region
order by avg(population);



-- 3. Determine the maximum and minimum `model_year` of stolen vehicles.
select max(model_year), min(model_year)
from stolenvehicles;




-- String Functions
-- 1. Retrieve the `make_name` from the `make_details` table and convert it to uppercase.
SELECT UPPER(make_name) AS make_name_uppercase
FROM make_details;


-- 2. Find the length of the `vehicle_desc` for each stolen vehicle.
select length(vehicle_desc)
from stolenvehicles;


-- 3. Concatenate the `vehicle_type` and `color` columns from the `stolen_vehicles` table into a single
-- column called "Description".
select vehicle_type as Description
from stolenvehicles
union 
select color
from stolenvehicles;

-- Update Records
-- 1. Update the `color` of all stolen vehicles with `vehicle_type` "Trailer" to "Black".
update stolenvehicles
set color = 'Black'
where vehicle_type like 'Trailer';
select *
from stolenvehicles;

-- 2. Change the `make_name` of `make_id` 623 to "New Make Name" in the `make_details` table.
UPDATE make_details
SET make_name = 'New Make Name'
WHERE make_id = 623;




-- Bonus Questions
-- 1. Write a query to find the top 3 regions with the highest number of stolen vehicles.
select l.region, count(vehicle_id)
from stolenvehicles s
inner join location l
on l.location_id=s.location_id
group by l.region
order by count(vehicle_id) desc
limit 3;


-- 2. Retrieve the `make_name` and the total number of stolen vehicles for each make, but only for makes
-- that have more than 5 stolen vehicles.
select m.make_name, count(vehicle_id)
from stolenvehicles s
inner join make_details m
on m.make_id=s.make_id
group by m.make_name
having count(vehicle_id) > 5;



-- 3. Use a JOIN to find the `region` and `country` where the most vehicles were stolen.
select l.region, l.country, count(vehicle_id)
from stolenvehicles s
inner join locations l
on l.location_id=s.location_id
group by l.region, l.country
order by count(vehicle_id) desc;

-- 4. Write a query to find the percentage of stolen vehicles that are of type "Boat Trailer".
 select
 cast(sum(case 
 when vehicle_type = 'Boat Trailer'
 then 1 else 0 end)as real)*100/count(*) Percentage_of_BoatTrailer
 from stolenvehicles;


-- 5. Use a CASE statement to create a new column called "Density_Category" that categorizes regions as
-- "High Density" if `density` is greater than 500, "Medium Density" if between 200 and 500, and "Low Density" if less than 200.
select *,
case
when density > 500 then 'High Density'
when density between 200 and 500 then 'Medium Density'
when density < 200 then 'Low Density'
end as Density_Category
from locations;