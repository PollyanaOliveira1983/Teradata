 

SELECT * FROM CHESS.Players;


--DISTINCT: to avoid duplicates
SELECT DISTINCT * FROM CHESS.Players;

SELECT Country FROM CHESS.Players;

SELECT DISTINCT Country FROM CHESS.Players;


--ALIAS: to give an alias name to a column

SELECT 
FIDE_ID,
First_Name,
Last_Name,
RATING AS Chess_Rating,
"Title" Chess_Title
FROM CHESS.Players;



--ORDER BY: to sort the rows

SELECT 
FIDE_ID,
First_Name,
Last_Name,
RATING AS Chess_Rating,
"Title" Chess_Title
FROM CHESS.Players
ORDER BY Rating; --defaults to ASC



--ORDER BY: to sort the rows

SELECT 
FIDE_ID,
First_Name,
Last_Name,
RATING AS Chess_Rating,
"Title" Chess_Title
FROM CHESS.Players
ORDER BY Rating DESC;



--ORDER BY: to sort the rows

SELECT 
FIDE_ID,
First_Name,
Last_Name,
RATING AS Chess_Rating,
"Title" Chess_Title
FROM CHESS.Players
ORDER BY 4 DESC; --the column number can be used instead of column name



--WHERE: to filter the results

SELECT *
FROM CHESS.Players
WHERE First_Name='garry';



--AND: Logical operator 

SELECT *
FROM CHESS.Players
WHERE birth_year>1980
AND Inactive_ind='i';



--OR: Logical operator 

SELECT *
FROM CHESS.Players
WHERE birth_year>2000
OR Inactive_ind='i';
