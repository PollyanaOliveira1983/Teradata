
--Greater than, smaller than

SELECT * 
FROM CHESS.Players
WHERE rating > 2650
ORDER BY rating;



--Greater than or equal to, smaller than or equal to

SELECT * 
FROM CHESS.Players
WHERE rating >= 2650
ORDER BY rating;



--Not equal to

SELECT * 
FROM CHESS.Players
ORDER BY rating;

SELECT * 
FROM CHESS.Players
WHERE rating <> 2601
ORDER BY rating;




--NOT: to negate the expression

SELECT * 
FROM CHESS.Players
WHERE rating NOT = 2601 
ORDER BY rating;



--IN, NOT IN
SELECT * 
FROM CHESS.Players
WHERE First_name IN ('sergei', 'sergey');



--BETWEEN
SELECT * 
FROM CHESS.Players
WHERE rating BETWEEN 2710 AND 2770 --inclusive from both ends
ORDER BY rating DESC;



--IS NULL, IS NOT NULL

SELECT * 
FROM CHESS.Players
WHERE Inactive_IND IS NULL;

SELECT * 
FROM CHESS.Players
WHERE Inactive_IND=''; --NULL doesn't mean empty! 

SEL * FROM dbc.tables
where CommentString IS NULL;

SEL * FROM dbc.tables
where CommentString IS NOT NULL;



--LIKE: expression to use wild characters

SELECT * 
FROM CHESS.Players
WHERE First_Name LIKE 'm%'; --% is wildcard for any number of any characters

SELECT * 
FROM CHESS.Players
WHERE First_Name LIKE 'y%y';

SELECT * 
FROM CHESS.Players
WHERE First_Name LIKE '_e_e_'; -- _ is wildcard for one number of any character

SELECT * 
FROM CHESS.Players
WHERE First_Name NOT LIKE 'm%';



--LIKE ANY (similar to LIKE SOME)

SELECT * 
FROM CHESS.Players
WHERE First_Name LIKE SOME ('m%', 'a%');

SELECT * 
FROM CHESS.Players
WHERE First_Name NOT LIKE ANY ('m%', 'a%'); --gets all rows, not very meaningful!



--LIKE ALL 

SELECT * 
FROM CHESS.Players
WHERE First_Name NOT LIKE ALL ('m%', 'a%');



--CASESPECIFIC: for case specific matching

SELECT * 
FROM CHESS.Players
WHERE First_Name (CASESPECIFIC) LIKE 's%';

SELECT * 
FROM CHESS.Players
WHERE First_Name (NOT CASESPECIFIC) LIKE 's%';
