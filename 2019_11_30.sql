SELECT *
FROM countries;

SELECT *
FROM regions;

SELECT *
FROM locations;

SELECT c.region_id, region_name, country_name
FROM countries c JOIN regions r ON (c.region_id = r.region_id);

SELECT c.region_id, region_name, country_name, city
FROM countries c JOIN regions r ON (c.region_id = r.region_id)
               JOIN locations l ON(c.country_id = l.country_id);
               

SELECT *
FROM departments;
