
--INNER JOIN

SELECT 
P.First_Name,
P.Last_Name,
P.Rating,
P.Country,
C.COuntry_CD,
C.Country_Name
FROM CHESS.Players P
INNER JOIN CHESS.Countries C
ON C.Country_CD=P.Country;


SELECT 
P.First_Name,
P.Last_Name,
P.Rating,
P.Country,
C.COuntry_CD,
C.Country_Name
FROM CHESS.Players P
JOIN CHESS.Countries C
ON C.Country_CD=P.Country;



--LEFT OUTER JOIN, returns INNER JOIN rows plus unmatched rows of the left table

SELECT 
P.First_Name,
P.Last_Name,
P.Rating,
P.Country,
C.COuntry_CD,
C.Country_Name
FROM CHESS.Players P
LEFT OUTER JOIN CHESS.Countries C
ON C.Country_CD=P.Country;



--RIGHT OUTER JOIN, returns INNER JOIN rows plus unmatched rows of the right table

SELECT 
P.First_Name,
P.Last_Name,
P.Rating,
P.Country,
C.COuntry_CD,
C.Country_Name
FROM CHESS.Players P
RIGHT OUTER JOIN CHESS.Countries C
ON C.Country_CD=P.Country;



--FULL OUTER JOIN, retunrs INNER JOIN rows plus unmatched rows of the left and right tables

SELECT 
P.First_Name,
P.Last_Name,
P.Rating,
P.Country,
C.COuntry_CD,
C.Country_Name
FROM CHESS.Players P
FULL OUTER JOIN CHESS.Countries C
ON C.Country_CD=P.Country;



-- CROSS JOIN, returns all combinations of first table rows next to second table rows (N*M rows)

SELECT 
P.First_Name,
P.Last_Name,
P.Rating,
P.Country,
C.COuntry_CD,
C.Country_Name
FROM CHESS.Players P
CROSS JOIN CHESS.Countries C;

