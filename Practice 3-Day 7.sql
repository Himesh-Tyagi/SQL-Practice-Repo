/* =====================================================
   BASIC SQL PRACTICE – QUESTIONS & ANSWERS
   TABLE: world
   ===================================================== */

/* Q1. Select countries with population between 1,000,000 and 1,250,000 */
SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000;


/* Q2. Result for names starting with 'Al' */
SELECT name, population
FROM world
WHERE name LIKE "Al%";
-- Albania | 3200000
-- Algeria | 32900000


/* Q3. Countries that end with 'A' or 'L' */
SELECT name
FROM world
WHERE name LIKE '%a' OR name LIKE '%l';


/* Q4. Result for European countries with 5-letter names */
SELECT name, length(name)
FROM world
WHERE length(name)=5 AND region='Europe';

-- Answer:
-- Italy | 5
-- Malta | 5
-- Spain | 5


/* Q5. Area doubled where population = 64000 */
SELECT name, area*2
FROM world
WHERE population = 64000;
-- Answer:
-- Andorra | 936


/* Q6. Countries with area > 50000 AND population < 10000000 */
SELECT name, area, population
FROM world
WHERE area > 50000
  AND population < 10000000;


/* Q7. Population density of given countries */
SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia');


/* =====================================================
   NOBEL SQL PRACTICE – QUESTIONS & ANSWERS
   TABLE: nobel
   ===================================================== */

/* Q8. Winners starting with 'C' and ending with 'n' */
SELECT winner
FROM nobel
WHERE winner LIKE 'C%' AND winner LIKE '%n';


/* Q9. Count of Chemistry awards between 1950 and 1960 */
SELECT COUNT(subject)
FROM nobel
WHERE subject = 'Chemistry'
  AND yr BETWEEN 1950 AND 1960;


/* Q10. Count of years with NO Medicine award */
SELECT COUNT(DISTINCT yr)
FROM nobel
WHERE yr NOT IN (
    SELECT DISTINCT yr
    FROM nobel
    WHERE subject = 'Medicine'
);


/* Q11. Result for winners starting with 'Sir' in the 1960s */
SELECT subject, winner
FROM nobel
WHERE winner LIKE 'Sir%'
  AND yr LIKE '196%';
-- Answer:
-- Medicine | Sir John Eccles
-- Medicine | Sir Frank Macfarlane Burnet
-- Chemistry | Sir Cyril Hinshelwood


/* Q12. Years with neither Physics nor Chemistry awards */
SELECT yr
FROM nobel
WHERE yr NOT IN (
    SELECT yr
    FROM nobel
    WHERE subject IN ('Physics', 'Chemistry')
);


/* Q13. Years with Medicine award but NO Peace or Literature award */
SELECT DISTINCT yr
FROM nobel
WHERE subject = 'Medicine'
  AND yr NOT IN (
      SELECT yr FROM nobel WHERE subject = 'Peace'
  )
  AND yr NOT IN (
      SELECT yr FROM nobel WHERE subject = 'Literature'
  );


/* Q14. Result for subject-wise count in year 1960 */
SELECT subject, COUNT(subject)
FROM nobel
WHERE yr = '1960'
GROUP BY subject;
-- Answer:
-- Chemistry | 1
-- Literature | 1
-- Medicine | 2
-- Peace | 1
-- Physics | 1
