/* =========================================================
   TOPIC: MOVIES DATABASE (movie, actor, casting)
   ========================================================= */

-- 1. List the films where the year is 1962 and the budget is over 2000000
SELECT id, title
FROM movie
WHERE yr = 1962
  AND budget > 2000000;

-- 2. Give the year of 'Citizen Kane'
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all Star Trek movies with id, title and year ordered by year
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

-- 4. Find the id of the actor 'Glenn Close'
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. Find the id of the 1942 film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca'
  AND yr = 1942;

-- 6. Obtain the cast list for the film 'Casablanca' (1942)
SELECT a.name
FROM actor a
JOIN casting c ON a.id = c.actorid
WHERE c.movieid = 11768;

-- 7. Obtain the cast list for the film 'Alien'
SELECT a.name
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE m.title = 'Alien';

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT m.title
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE a.name = 'Harrison Ford';

-- 9. List the films where 'Harrison Ford' appeared but not in the starring role
SELECT m.title
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE a.name = 'Harrison Ford'
  AND c.ord <> 1;

-- 10. List the films and their leading actor for all 1962 movies
SELECT m.title, a.name
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE m.yr = 1962
  AND c.ord = 1;

-- 11. Show the busiest years for 'Rock Hudson' (more than 2 movies)
SELECT m.yr, COUNT(m.title) AS movie_count
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE a.name = 'Rock Hudson'
GROUP BY m.yr
HAVING COUNT(m.title) > 2;

-- 12. List the film title and leading actor for all movies Julie Andrews appeared in
SELECT DISTINCT m.title, a2.name
FROM movie m
JOIN casting c1 ON m.id = c1.movieid
JOIN actor a1 ON c1.actorid = a1.id
JOIN casting c2 ON m.id = c2.movieid
JOIN actor a2 ON c2.actorid = a2.id
WHERE a1.name = 'Julie Andrews'
  AND c2.ord = 1;

-- 13. List actors who have had at least 15 leading roles
SELECT a.name
FROM actor a
JOIN casting c ON a.id = c.actorid
WHERE c.ord = 1
GROUP BY a.name
HAVING COUNT(*) >= 15
ORDER BY a.name;

-- 14. List films released in 1978 ordered by cast size and title
SELECT m.title, COUNT(c.actorid) AS actor_count
FROM movie m
JOIN casting c ON m.id = c.movieid
WHERE m.yr = 1978
GROUP BY m.title
ORDER BY actor_count DESC, m.title;

-- 15. List all people who have worked with 'Art Garfunkel'
SELECT DISTINCT a2.name
FROM actor a1
JOIN casting c1 ON a1.id = c1.actorid
JOIN casting c2 ON c1.movieid = c2.movieid
JOIN actor a2 ON c2.actorid = a2.id
WHERE a1.name = 'Art Garfunkel'
  AND a2.name <> 'Art Garfunkel';


/* =========================================================
   TOPIC: TEACHER & DEPARTMENT (NULL, JOIN, COALESCE, CASE)
   ========================================================= */

-- 1. List teachers with no department
SELECT name
FROM teacher
WHERE dept IS NULL;

-- 2. Show teachers and their departments (INNER JOIN)
SELECT teacher.name, dept.name
FROM teacher
INNER JOIN dept
ON teacher.dept = dept.id;

-- 3. Show all teachers including those without departments
SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept
ON teacher.dept = dept.id;

-- 4. Show all departments including those without teachers
SELECT teacher.name, dept.name
FROM teacher
RIGHT JOIN dept
ON teacher.dept = dept.id;

-- 5. Show teacher name and mobile number, use default if NULL
SELECT name,
       COALESCE(mobile, '07986 444 2266') AS mobile
FROM teacher;

-- 6. Show teacher name and department, use 'None' if no department
SELECT teacher.name,
       COALESCE(dept.name, 'None') AS department
FROM teacher
LEFT JOIN dept
ON teacher.dept = dept.id;

-- 7. Count number of teachers and number of mobile numbers
SELECT COUNT(name) AS teacher_count,
       COUNT(mobile) AS mobile_count
FROM teacher;

-- 8. Show each department and number of staff (include Engineering)
SELECT d.name, COUNT(t.id) AS staff_count
FROM teacher t
RIGHT JOIN dept d
ON t.dept = d.id
GROUP BY d.name;

-- 9. Categorize teachers as Sci or Art using CASE
SELECT name,
       CASE
           WHEN dept IN (1,2) THEN 'Sci'
           ELSE 'Art'
       END AS category
FROM teacher;

-- 10. Categorize teachers as Sci, Art or None using CASE
SELECT name,
       CASE
           WHEN dept IN (1,2) THEN 'Sci'
           WHEN dept = 3 THEN 'Art'
           ELSE 'None'
       END AS category
FROM teacher;


/* =========================================================
   TOPIC: EDINBURGH BUS ROUTES (SELF JOIN)
   ========================================================= */

-- 1. Count the number of stops
SELECT COUNT(*) 
FROM stops;

-- 2. Find the id for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3. List stops on route 4 operated by LRT
SELECT DISTINCT s.id, s.name
FROM stops s
JOIN route r ON s.id = r.stop
WHERE r.num = '4'
  AND r.company = 'LRT';

-- 4. Routes visiting both Craiglockhart and London Road
SELECT company, num, COUNT(*) AS stop_count
FROM route
WHERE stop IN (53, 149)
GROUP BY company, num
HAVING COUNT(*) > 1;

-- 5. Services from Craiglockhart to London Road
SELECT a.company, a.num
FROM route a
JOIN route b
ON a.company = b.company
AND a.num = b.num
WHERE a.stop = 53
  AND b.stop = 149;

-- 6. Services between Craiglockhart and London Road using stop names
SELECT a.company, a.num
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops s1 ON a.stop = s1.id
JOIN stops s2 ON b.stop = s2.id
WHERE s1.name = 'Craiglockhart'
  AND s2.name = 'London Road';

-- 7. Services connecting Haymarket and Leith
SELECT DISTINCT r1.company, r1.num
FROM route r1
JOIN route r2
ON r1.company = r2.company
AND r1.num = r2.num
WHERE r1.stop = 115
  AND r2.stop = 137;

-- 8. Services connecting Craiglockhart and Tollcross
SELECT DISTINCT r1.company, r1.num
FROM route r1
JOIN route r2 ON r1.company = r2.company AND r1.num = r2.num
JOIN stops s1 ON r1.stop = s1.id
JOIN stops s2 ON r2.stop = s2.id
WHERE s1.name = 'Craiglockhart'
  AND s2.name = 'Tollcross';

-- 9. Stops reachable from Craiglockhart using one LRT bus
SELECT DISTINCT s2.name, r1.company, r1.num
FROM route r1
JOIN route r2 ON r1.company = r2.company AND r1.num = r2.num
JOIN stops s1 ON r1.stop = s1.id
JOIN stops s2 ON r2.stop = s2.id
WHERE s1.name = 'Craiglockhart'
  AND r1.company = 'LRT';

-- 10. Two-bus routes from Craiglockhart to Lochend
SELECT r1.company AS first_company,
       r1.num AS first_bus,
       s.name AS transfer_stop,
       r3.company AS second_company,
       r3.num AS second_bus
FROM route r1
JOIN route r2 ON r1.company = r2.company AND r1.num = r2.num
JOIN route r3 ON r2.stop = r3.stop
JOIN route r4 ON r3.company = r4.company AND r3.num = r4.num
JOIN stops s1 ON r1.stop = s1.id
JOIN stops s ON r2.stop = s.id
JOIN stops s2 ON r4.stop = s2.id
WHERE s1.name = 'Craiglockhart'
  AND s2.name = 'Lochend'
  AND NOT (r1.company = r3.company AND r1.num = r3.num);
