
-- RANK (an Ordered Analytical Function): creates an ordered sequence in given partitions (if partitions provided)

SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(PARTITION BY Country ORDER BY Rating DESC) Country_Ranking 
FROM CHESS.Players
ORDER BY Rating DESC;


SELECT 
First_Name,
Last_Name,
Rating,
Country,
Inactive_IND,
RANK() OVER(PARTITION BY Country, Inactive_IND ORDER BY Rating DESC) Country_Ranking 
FROM CHESS.Players
ORDER BY Rating DESC;


SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(PARTITION BY Country ORDER BY Rating DESC) Country_Ranking 
FROM CHESS.Players
WHERE Inactive_IND <> 'i' --with this filter, ranking applies to RANK function too
ORDER BY Rating DESC;



--QUALIFY: a filter that uses a previously computed ordered analytical function

SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(PARTITION BY Country ORDER BY Rating DESC) Country_Ranking 
FROM CHESS.Players
WHERE Inactive_IND <> 'i' 
ORDER BY Rating DESC
QUALIFY Country_Ranking = 1; --to see the top player of each country. Without using aggregation!


SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(PARTITION BY Country ORDER BY Rating DESC) Country_Ranking 
FROM CHESS.Players
WHERE Inactive_IND <> 'i' 
ORDER BY Rating DESC
QUALIFY Country_Ranking <= 2; --to see the top 2 players of each country


SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(PARTITION BY Country ORDER BY Rating DESC) Country_Ranking 
FROM CHESS.Players
WHERE Inactive_IND <> 'i' 
AND Country_Ranking <= 2 --NOPE!
ORDER BY Rating DESC;



SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(PARTITION BY Country ORDER BY Rating DESC) Country_Ranking 
FROM CHESS.Players
WHERE Inactive_IND <> 'i' 
ORDER BY Rating DESC
HAVING Country_Ranking <= 2; --NOPE!


SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(ORDER BY Rating DESC) Ranking
FROM CHESS.Players
ORDER BY Rating DESC
QUALIFY Ranking <= 10; --there could be ties with the same ranking


SELECT 
First_Name,
Last_Name,
Rating,
Country,
RANK() OVER(ORDER BY Rating DESC) Ranking
FROM CHESS.Players
ORDER BY Rating DESC
QUALIFY Ranking <= 9; --even though we wanted up to rank 9 we get 10 rows




--ROW_NUMBER (another Ordered Analytical Function): similar to RANK but gives the ranking serially even for ties

SELECT 
First_Name,
Last_Name,
Rating,
Country,
ROW_NUMBER() OVER(ORDER BY Rating DESC) Ranking
FROM CHESS.Players
ORDER BY Rating DESC
QUALIFY Ranking <= 9; --even though we wanted up to rank 9 we get 10 rows
