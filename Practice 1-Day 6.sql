-- =====================================================
-- SQL SELECT Tutorial : Questions & Answers
-- Table: world
-- =====================================================

-- Columns:
-- name | continent | area | population | gdp | capital

-- -----------------------------------------------------
-- 1. Introduction
-- Show the name, continent and population of all countries.
SELECT name, continent, population
FROM world;

-- -----------------------------------------------------
-- 2. Large Countries
-- Show the name for countries with population at least 200 million.
SELECT name
FROM world
WHERE population >= 200000000;

-- -----------------------------------------------------
-- 3. Per Capita GDP
-- Show name and per capita GDP for countries with population >= 200 million.
SELECT name, gdp / population AS per_capita_gdp
FROM world
WHERE population >= 200000000;

-- -----------------------------------------------------
-- 4. South America in Millions
-- Show name and population (in millions) for South America.
SELECT name, population / 1000000 AS population_millions
FROM world
WHERE continent = 'South America';

-- -----------------------------------------------------
-- 5. France, Germany, Italy
-- Show name and population for France, Germany, and Italy.
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- -----------------------------------------------------
-- 6. United
-- Show countries that include the word 'United' in their name.
SELECT name
FROM world
WHERE name LIKE '%United%';

-- -----------------------------------------------------
-- 7. Two Ways to Be Big
-- Big if area > 3 million sq km OR population > 250 million.
SELECT name, population, area
FROM world
WHERE area > 3000000
   OR population > 250000000;

-- -----------------------------------------------------
-- 8. One or the Other (but not both)
-- Big by area OR big by population, but not both.
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population <= 250000000)
   OR (population > 250000000 AND area <= 3000000);

-- -----------------------------------------------------
-- 9. Rounding
-- For South America show population in millions and GDP in billions (2 decimals).
SELECT 
    name,
    ROUND(population / 1000000, 2) AS population_millions,
    ROUND(gdp / 1000000000, 2) AS gdp_billions
FROM world
WHERE continent = 'South America';

-- -----------------------------------------------------
-- 10. Trillion Dollar Economies
-- Show name and per-capita GDP (rounded to nearest 1000)
-- for countries with GDP >= 1 trillion.
SELECT name, ROUND(gdp / population, -3) AS per_capita_gdp
FROM world
WHERE gdp >= 1000000000000;

-- -----------------------------------------------------
-- 11. Name and Capital Have the Same Length
-- Show countries where name length equals capital length.
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- -----------------------------------------------------
-- 12. Matching Name and Capital
-- First letter of name and capital must match,
-- but name and capital should not be the same.
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital;

-- -----------------------------------------------------
-- 13. All the Vowels
-- Country name must contain all vowels (a, e, i, o, u)
-- and must not contain spaces.
SELECT name
FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';
  

-- ================================================================================================================================================================================
-- Nobel Prize SQL Practice
-- Table: nobel(yr, subject, winner)
-- ============================================

-- 1. Nobel prizes for the year 1950
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2. Winner of the 1962 Literature prize
SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'Literature';

-- 3. Year and subject for Albert Einstein's Nobel Prize
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4. Peace prize winners since 2000 (including 2000)
SELECT winner
FROM nobel
WHERE subject = 'Peace'
  AND yr >= 2000;

-- 5. Literature winners from 1980 to 1989
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature'
  AND yr BETWEEN 1980 AND 1989;

-- 6. Nobel Prize winners who were Presidents
SELECT *
FROM nobel
WHERE winner IN (
    'Theodore Roosevelt',
    'Thomas Woodrow Wilson',
    'Jimmy Carter',
    'Barack Obama'
);

-- 7. Winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

-- 8. Physics winners of 1980 and Chemistry winners of 1984
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Physics' AND yr = 1980
UNION
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Chemistry' AND yr = 1984;

-- 9. Winners of 1980 excluding Chemistry and Medicine
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980
  AND subject NOT IN ('Chemistry', 'Medicine');

-- 10. Early Medicine winners (before 1910)
--     and Late Literature winners (from 2004 onwards)
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Medicine'
  AND yr < 1910
UNION
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature'
  AND yr >= 2004;

-- 11. Prize details for PETER GRÜNBERG
SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12. Prize details for EUGENE O'NEILL
SELECT *
FROM nobel
WHERE winner = 'EUGENE O''NEILL';

-- 13. Knights of the realm (Sir), most recent first
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner;

-- 14. 1984 winners ordered with Chemistry and Physics listed last
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('Chemistry', 'Physics'), subject, winner;

