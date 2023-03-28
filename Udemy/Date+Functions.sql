
-- DATE Functions
-- Internally stored as numeric value of (year - 1900) * 10000 + (month * 100) + day, with some constraints


SELECT * FROM CHESS.games;




SEL TYPE(game_date)
FROM CHESS.games SAMPLE 1;




SHOW TABLE CHESS.games;




SELECT * FROM CHESS.games
WHERE game_date=CAST('2020-01-11' AS DATE);




SELECT * FROM CHESS.games
WHERE game_date=CAST('01-11-2020' AS DATE); -- non-default format needs format specification




SELECT * FROM CHESS.games
WHERE game_date=CAST('01 11 2020' AS DATE FORMAT 'MMBDDBYYYY');




SELECT * FROM CHESS.games
WHERE game_date=CAST('01-11-2020' AS DATE FORMAT 'mm-DD-yYyY'); --FORMAT string is case INsensitive! 




SELECT CAST('2020 Mar 30' AS DATE FORMAT 'YYYYBMMMBDD'); --different formats



SELECT CURRENT_DATE - CAST('2000-01-01' AS DATE); --returns a number which is the number of days




SELECT ( CURRENT_DATE - CAST('2000-01-01' AS DATE) )/365.25;




--TO_DATE is another option

SELECT * FROM CHESS.games
WHERE game_date=TO_DATE('2020-01-11');




SELECT * FROM CHESS.games
WHERE game_date=TO_DATE('01-11-2020', 'mm-dd-yyyy');




-- INTERVAL: to add (subtract) a period to (from) a date field

SELECT CURRENT_DATE;




SELECT CURRENT_DATE + INTERVAL '1' DAY;




SELECT CURRENT_DATE - INTERVAL '1' DAY; --to subtract




SELECT CURRENT_DATE + INTERVAL -'1' DAY; --to subtract





SELECT CURRENT_DATE,
CURRENT_DATE + INTERVAL '1' DAY,
CURRENT_DATE - INTERVAL '1' DAY,
CURRENT_DATE + INTERVAL '2' MONTH,
CURRENT_DATE - INTERVAL '2' MONTH,
CURRENT_DATE + INTERVAL '3' YEAR,
CURRENT_DATE - INTERVAL '3' YEAR;




SELECT * FROM CHESS.games
WHERE game_date BETWEEN CAST('2020-01-11' AS DATE) AND (CAST('2020-01-11' AS DATE) + INTERVAL '5' DAY); --next 5 days




SELECT * FROM CHESS.games
WHERE game_date BETWEEN (CAST('2020-01-20' AS DATE) - INTERVAL '4' DAY) AND CAST('2020-01-20' AS DATE); --last 4 days





SELECT * FROM CHESS.games
WHERE game_date BETWEEN (CURRENT_DATE - INTERVAL '1' YEAR) AND (CURRENT_DATE);




SELECT * FROM CHESS.games
WHERE game_date BETWEEN (CURRENT_DATE - INTERVAL '2' YEAR) AND (CURRENT_DATE - INTERVAL '1' YEAR);




SELECT CURRENT_DATE + INTERVAL '2' MONTH + INTERVAL '1' DAY; -- INTERVAL can be used for adding day/month/year all together




SELECT CURRENT_DATE,
CURRENT_DATE + INTERVAL '6-01' YEAR TO MONTH;




SELECT CURRENT_DATE + INTERVAL '1-10' MONTH TO DAY; -- Boooooooo!




-- EXTRACT: to get day/month/year value of a DATE field

SELECT CURRENT_DATE,
EXTRACT(YEAR FROM CURRENT_DATE),
EXTRACT(MONTH FROM CURRENT_DATE),
EXTRACT(DAY FROM CURRENT_DATE);




SELECT TYPE( EXTRACT(DAY FROM CURRENT_DATE) );  --EXTRACT returns integer data dype




SELECT * FROM CHESS.Games
WHERE EXTRACT(DAY FROM game_date) BETWEEN 18 AND 22;

