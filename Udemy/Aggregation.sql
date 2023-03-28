
--Aggregate operators compute summary values

SELECT 
COUNT(*)
FROM CHESS.PLayers;


SELECT 
MIN(Birth_Year),
MAX(Birth_Year),
AVG(Birth_Year),
SUM(Birth_Year),
COUNT(Birth_Year) 
FROM CHESS.PLayers; --all are "aggregate" columns


SELECT 
STDDEV_POP(Rating), --population standard deviation for the non-null data points
STDDEV_SAMP(Rating), --sample standard deviation for the non-null data points
VAR_POP(Rating), --population variance
VAR_SAMP(Rating) --sample variance
FROM CHESS.PLayers;



SELECT 
COUNT(*),
COUNT(C.Country_Name), -- NULLs are ignored
COUNT(distinct COUNTRY_Name) --NULLs are ignored
FROM CHESS.Players P
LEFT OUTER JOIN CHESS.Countries C
ON C.Country_CD=P.Country;



SELECT 
distinct country_name
FROM CHESS.Players P
LEFT OUTER JOIN CHESS.Countries C
ON C.Country_CD=P.Country;



--GROUP BY: to aggregate (summarize) for each value of a column

SELECT 
Country, --"non-aggregate" column
COUNT(*) Player_Count
FROM CHESS.Players
GROUP BY Country
ORDER BY Player_COUNT DESC;


SELECT 
Country,
COUNT(*) Player_Count, --number of players by country
MAX(Rating) MAX_Rating --highest rated player of each country
FROM CHESS.Players
GROUP BY Country
ORDER BY MAX_Rating DESC;



--GROUP BY can be with multiple columns

SELECT 
Country,
Inactive_IND, 
COUNT(*) Player_Count
FROM CHESS.Players
GROUP BY Country
ORDER BY Player_COUNT DESC; --WON'T WORK!


SELECT 
Country,
Inactive_IND,
COUNT(*) Player_Count
FROM CHESS.Players
GROUP BY Country, Inactive_IND
ORDER BY Player_COUNT DESC;


SELECT 
Country,
Inactive_IND,
COUNT(*) Player_Count
FROM CHESS.Players
GROUP BY Country, Inactive_IND
ORDER BY Inactive_IND, Player_COUNT DESC; --to order by both GROUP BY columns


SELECT 
Country,
Inactive_IND,
COUNT(*) Player_Count
FROM CHESS.Players
GROUP BY 1, 2 --instead of column names, column numbers can be used too
ORDER BY Inactive_IND, Player_COUNT DESC; 


SELECT 
Country,
Inactive_IND,
COUNT(*) Player_Count
FROM CHESS.Players
GROUP BY 1, 2 
ORDER BY 2, 3 DESC; --similar to how numbers can be used for ORDER BY columns


--Filters, HAVING applies to aggregate columns, WHERE applies to non-aggregate columns

SELECT 
Country,
COUNT(*) Player_Count
FROM CHESS.Players
GROUP BY Country
ORDER BY Player_Count DESC;


SELECT 
Country,
COUNT(*) Player_Count
FROM CHESS.Players
WHERE Birth_Year > 1990
GROUP BY Country
ORDER BY Player_Count DESC;


SELECT 
Country,
COUNT(*) Player_Count
FROM CHESS.Players
HAVING Player_Count > 5
GROUP BY Country
ORDER BY Player_Count DESC;


SELECT 
Country,
COUNT(*) Player_Count
FROM CHESS.Players
WHERE Player_Count > 5 --Can't do this
GROUP BY Country
ORDER BY Player_Count DESC;


SELECT 
Country,
COUNT(*) Player_Count
FROM CHESS.Players
HAVING Birth_Year > 1990 --Can't do this
GROUP BY Country
ORDER BY Player_Count DESC;


