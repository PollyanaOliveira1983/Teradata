
--SAMPLE: to get a sample of the rows returned by the query

SELECT *
FROM CHESS.Players
SAMPLE 100;

SELECT *
SAMPLE 100 --could be before the FROM clause as well
FROM CHESS.Players;

SELECT *
FROM CHESS.Players
SAMPLE 100
WHERE Inactive_IND <> 'i'



--if 0 < N < 1 returns that portion of the rows

SELECT *
FROM CHESS.Players
SAMPLE 0.1; --rounds up if the portion is not an integer



--SAMPLE RANDOMIZED ALLOCATION: for a real random selection

SELECT * 
FROM CHESS.Players
SAMPLE RANDOMIZED ALLOCATION 0.1;



-- TOP: returns top N rows based on ORDER BY clause

SELECT TOP 20 * 
FROM CHESS.Players
ORDER BY Rating DESC;

SELECT TOP 20 * 
FROM CHESS.Players; --without an ORDER BY it's similar to SAMPLE but less random



-- TOP PERCENT

SELECT TOP 10 PERCENT *
FROM CHESS.Players
ORDER BY Rating DESC;



-- TOP N WITH TIES

SELECT TOP 10 * 
FROM CHESS.Players
ORDER BY Rating DESC;

SELECT TOP 9 * 
FROM CHESS.Players
ORDER BY Rating DESC;

SELECT TOP 9 WITH TIES * --this includes the ties 
FROM CHESS.Players
ORDER BY Rating DESC; --without the ORDER BY, the WITH TIES doesn't do anything
