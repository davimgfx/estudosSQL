-- 1 List all the Canadian cities and their populations 
SELECT city, country, population FROM north_american_cities 
WHERE country LIKE "Canada" 

-- 2 Order all the cities in the United States by their latitude from north to south
-- First Select the columns
-- Second use WHERE and LIKE to select just USA
-- Third use ORDER BY to filter
SELECT city, country, latitude FROM north_american_cities 
WHERE country LIKE "United States" ORDER BY latitude DESC;

-- 3 List all the cities west of Chicago, ordered from west to east
SELECT city, longitude FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;

-- 4 List the two largest cities in Mexico (by population)
SELECT city,  country, population FROM north_american_cities 
WHERE country LIKE "Mexico"  ORDER BY population DESC LIMIT 2

--5 List the third and fourth largest cities (by population) in the United States and their population 
SELECT city,  country, population FROM north_american_cities 
WHERE country LIKE "United States"  ORDER BY population DESC LIMIT 2 OFFSET