
-- SET Operators: combine results from multiple SELECT statements
-- Difference with joins: JOINs combine COLUMNS of different tables, SETs combine ROWS of different tables.


CREATE TABLE CHESS.Players_Archived AS (

	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	WHERE Last_Name LIKE ANY ('%o%', '%e%')
	AND Birth_Year MOD 3=1
) WITH DATA;

INSERT INTO CHESS.Players_Archived VALUES ('Mahyar', 'Peysepar', '2805', 'i');

SEL * FROM CHESS.Players_Archived;



-- UNION

SELECT 
First_Name,
Last_Name,
Rating,
Inactive_IND
FROM CHESS.Players

UNION

SELECT 
First_Name,
Last_Name,
Rating,
Inactive_IND
FROM CHESS.Players_Archived;



--To sort out the results:

SELECT *
FROM (
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	
	UNION
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players_Archived
	) U
ORDER BY U.Rating DESC;



--UNION ALL

SELECT *
FROM (
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	
	UNION ALL
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players_Archived
	) U
ORDER BY U.Rating DESC;



-- SET Operators can work on multiple queries

SELECT *
FROM (
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	
	UNION ALL
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players_Archived
	
	UNION ALL --adding a 3rd query
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	WHERE Inactive_IND='i'
	) U
ORDER BY U.Rating DESC;



-- INTERSECT: returns only common rows

SELECT *
FROM (
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	
	INTERSECT
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players_Archived
	) U
ORDER BY U.Rating DESC;



-- EXCEPT: returns rows from first query that don't exist in the second query (MINUS does the same thing)

SELECT *
FROM (
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	
	EXCEPT
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players_Archived
	) U
ORDER BY U.Rating DESC; --rows in Players that don't exist in Players_Archived


SELECT *
FROM (
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players_Archived

	EXCEPT
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	) U
ORDER BY U.Rating DESC; --rows in Players_Archived that don't exist in Players



--MINUS: works like EXCEPT. Returns rows from first query that don't exist in the second query

SELECT *
FROM (
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players_Archived

	MINUS
	
	SELECT 
	First_Name,
	Last_Name,
	Rating,
	Inactive_IND
	FROM CHESS.Players
	) U
ORDER BY U.Rating DESC; --rows in Players_Archived that don't exist in Players



DROP TABLE CHESS.Players_Archived; --dropping this practice table
