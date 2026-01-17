-- ============================================
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
