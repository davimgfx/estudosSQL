-- 1 Find the movie with a row id of 6
SELECT id, title FROM movies WHERE id == 6;

-- 2 Find the movies released in the years between 2000 and 2010
SELECT year, title FROM movies WHERE year => 2000 AND year <= 2010;

-- 3 Find the movies not released in the years between 2000 and 2010 
SELECT year, title FROM movies 
WHERE year NOT BETWEEN 2000 and 2010

-- 4 Find the first 5 Pixar movies and their release year
SELECT title, year FROM movies LIMIT 5;

-- 1 Find all the Toy Story movies 
SELECT title FROM movies WHERE title LIKE "Toy Story%"

-- 2 Find all the movies directed by John Lasseter
SELECT title, director FROM movies WHERE director LIKE "John Lasseter"

-- 3 Find all the movies (and director) not directed by John Lasseter 
SELECT title, director FROM movies WHERE director NOT LIKE "John Lasseter"

-- 4 Find all the WALL-* movies 
SELECT title FROM movies WHERE title LIKE "WALL-%"