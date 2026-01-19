-- WORLD TABLE : AGGREGATE FUNCTIONS

-- Q1. Show the total population of the world
SELECT SUM(population) FROM world;

-- Q2. List all the continents (each once)
SELECT DISTINCT continent FROM world;

-- Q3. Give the total GDP of Africa
SELECT SUM(gdp) FROM world WHERE continent = 'Africa';

-- Q4. How many countries have an area of at least 1,000,000
SELECT COUNT(name) FROM world WHERE area >= 1000000;

-- Q5. Total population of Estonia, Latvia and Lithuania
SELECT SUM(population) 
FROM world 
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- Q6. Number of countries in each continent
SELECT continent, COUNT(name) 
FROM world 
GROUP BY continent;

-- Q7. Countries with population ≥ 10 million in each continent
SELECT continent, COUNT(name) 
FROM world 
WHERE population >= 10000000 
GROUP BY continent;

-- Q8. Continents with total population ≥ 100 million
SELECT continent 
FROM world 
GROUP BY continent 
HAVING SUM(population) >= 100000000;


-- BBC TABLE : AGGREGATES & GROUP BY

-- Q9. Sum of population of Europe
SELECT SUM(population) 
FROM bbc 
WHERE region = 'Europe';

-- Q10. Number of countries with population < 150000
SELECT COUNT(name) 
FROM bbc 
WHERE population < 150000;

-- Q11. Core SQL aggregate functions
-- AVG(), COUNT(), MAX(), MIN(), SUM()

-- Q12. Average population of Poland, Germany and Denmark
SELECT AVG(population) 
FROM bbc 
WHERE name IN ('Poland', 'Germany', 'Denmark');

-- Q13. Average population density of each region
SELECT region, SUM(population)/SUM(area) AS density
FROM bbc
GROUP BY region;

-- Q14. Country with the largest population and its density
SELECT name, population/area AS density
FROM bbc
WHERE population = (SELECT MAX(population) FROM bbc);

-- Q15. Regions with total area ≤ 20,000,000
SELECT region
FROM bbc
GROUP BY region
HAVING SUM(area) <= 20000000;


-- UEFA EURO 2012 : JOIN QUERIES

-- Q16. Match id and player for all goals scored by Germany
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- Q17. Match details for game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- Q18. German goals with player, team, stadium and date
SELECT player, teamid, stadium, mdate
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER';

-- Q19. Team1, team2 and player for goals scored by Mario
SELECT team1, team2, player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%';

-- Q20. Goals scored in first 10 minutes with coach
SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam ON teamid = id
WHERE gtime <= 10;

-- Q21. Match dates where Fernando Santos was team1 coach
SELECT mdate, teamname
FROM eteam
JOIN game ON team1 = eteam.id
WHERE coach = 'Fernando Santos';

-- Q22. Players who scored in National Stadium, Warsaw
SELECT player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';

-- Q23. Players who scored against Germany
SELECT DISTINCT goal.player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE (team1 = 'GER' OR team2 = 'GER')
  AND teamid != 'GER';

-- Q24. Total goals scored by each team
SELECT teamname, COUNT(gtime)
FROM eteam
JOIN goal ON id = teamid
GROUP BY teamname;

-- Q25. Goals scored in each stadium
SELECT stadium, COUNT(gtime)
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium;

-- Q26. Matches involving POL with total goals
SELECT game.id, mdate, COUNT(gtime) AS goals
FROM game
JOIN goal ON game.id = goal.matchid
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY game.id, mdate;

-- Q27. Matches where GER scored goals
SELECT matchid, mdate, COUNT(gtime)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

-- Q28. Match result showing goals by each team
SELECT 
    mdate,
    team1,
    SUM(CASE WHEN goal.teamid = team1 THEN 1 ELSE 0 END) AS score1,
    team2,
    SUM(CASE WHEN goal.teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game
LEFT JOIN goal ON game.id = goal.matchid
GROUP BY game.id, mdate, team1, team2
ORDER BY mdate, game.id;
